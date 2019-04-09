Return-Path: <SRS0=D3m8=SL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61C00C10F0E
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 19:11:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3609B2084F
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 19:11:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726950AbfDITLv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Apr 2019 15:11:51 -0400
Received: from lb3-smtp-cloud9.xs4all.net ([194.109.24.30]:39498 "EHLO
        lb3-smtp-cloud9.xs4all.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726497AbfDITLu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Apr 2019 15:11:50 -0400
Received: from xps13 ([83.160.161.190])
        by smtp-cloud9.xs4all.net with ESMTPSA
        id Dw9ohQUhdiLOmDw9rh4pfW; Tue, 09 Apr 2019 21:11:47 +0200
Message-ID: <10ca99831556bed2849e16caa5a4810628dc320c.camel@tiscali.nl>
Subject: Re: CONFIG_* symbols in UAPI headers?
From:   Paul Bolle <pebolle@tiscali.nl>
To:     Christoph Hellwig <hch@lst.de>, Jie Zhang <jie.zhang@analog.com>
Cc:     Mike Frysinger <vapier@gentoo.org>,
        David Howells <dhowells@redhat.com>,
        Arnd Bergmann <arnd@arndb.de>, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Tue, 09 Apr 2019 21:11:44 +0200
In-Reply-To: <20190408124640.GA607@lst.de>
References: <20190408124640.GA607@lst.de>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-3.fc28) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfIPQIcZ4KvPu46+eDT2MM+SEWOGQy7P6d90TqyeXZL4+8n6Kcpj1u7s8SqKxOxsElumt/RD0XJ1QdhsAh+GaY3bPKanWxZGgCv22PoTyDPfDjaVQ46wn
 C00u7ZdajfgQIEN8I93G4w65JXcbUFoV7yhpos9x7nMBYUqs/oI8umQqM3lFIKsG0azvYmFFKfwfEzSaLxe2NbI/i3GRlmb7DSlbHRUabzhSvfzOqMUH09C9
 kxat3GDuuf9fWDIywSlFNFVJ3G/skKoQ9HendIWw/GyY38lSoy4LzG/yCua7E7lo160e62+TekNQxmG0KF1J8t7kWLXh+pi+BiSlgyVz4Cs=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Hellwig schreef op ma 08-04-2019 om 14:46 [+0200]:
> There are a few similar issues, like struct elf_prstatus having
> a different layout depending on CONFIG_BINFMT_ELF_FDPIC, or
> MAX_SHARED_LIBS defending on CONFIG_BINFMT_SHARED_FLAT.

I've had the patch pasted below in a local branch for over five years, but
never dared to push it upstream.

Does it still apply?

Thanks,


Paul Bolle 

-- >8 ---
From 0f73c8ee776c197e3029c4eed21af0f121a8f9d3 Mon Sep 17 00:00:00 2001
From: Paul Bolle <pebolle@tiscali.nl>
Date: Tue, 4 Feb 2014 22:22:48 +0100
Subject: [PATCH] headers_check: enable check for CONFIG_ leakage

The check for leaked CONFIG_ symbols was disabled in v2.6.30, because it
generated too much noise. But a (rather simplistic) preprocessing of
comments suffices to silence the noise (ie, no false positives are
reported anymore).

So add some preprocessing of comments and enable check_config() again.

Signed-off-by: Paul Bolle <pebolle@tiscali.nl>
---
 scripts/headers_check.pl | 33 ++++++++++++++++++++++++++++-----
 1 file changed, 28 insertions(+), 5 deletions(-)

diff --git a/scripts/headers_check.pl b/scripts/headers_check.pl
index b6aec5e4365f..8e67017c1b67 100755
--- a/scripts/headers_check.pl
+++ b/scripts/headers_check.pl
@@ -36,13 +36,36 @@ foreach my $file (@files) {
 	open(my $fh, '<', $filename)
 		or die "$filename: $!\n";
 	$lineno = 0;
+	my $in_comment = 0;
+	my $swap_state = 0;
 	while ($line = <$fh>) {
 		$lineno++;
-		&check_include();
-		&check_asm_types();
-		&check_sizetypes();
-		&check_declarations();
-		# Dropped for now. Too much noise &check_config();
+
+		# strip inline comments
+		$line =~ s|/\*.*\*/||;
+
+		# try to handle multi line comments
+		if ($in_comment == 0 and $line =~ m|/\*|) {
+			$line =~ s|/\*.*$||;
+			# we still need to check (the first half of) this line
+			# so we set $in_comment after the checks
+			$swap_state = 1;
+		}
+		if ($in_comment == 1 and $line =~ m|\*/|) {
+			$line =~ s|^.*\*/||;
+			$in_comment = 0;
+		}
+		unless ($in_comment) {
+			check_include();
+			check_asm_types();
+			check_sizetypes();
+			check_declarations();
+			check_config();
+		}
+		if ($swap_state)  {
+			$in_comment = 1;
+			$swap_state = 0;
+		}
 	}
 	close $fh;
 }
-- 
2.17.2

