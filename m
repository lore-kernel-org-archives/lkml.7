Return-Path: <SRS0=WRlz=SV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B194DC282DA
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 18:22:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 87561222AF
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 18:22:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727344AbfDSSWh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Apr 2019 14:22:37 -0400
Received: from smtprelay0054.hostedemail.com ([216.40.44.54]:56034 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727386AbfDSSWf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Apr 2019 14:22:35 -0400
Received: from smtprelay.hostedemail.com (10.5.19.251.rfc1918.com [10.5.19.251])
        by smtpgrave04.hostedemail.com (Postfix) with ESMTP id A37AC1802F6BE
        for <linux-kernel@vger.kernel.org>; Fri, 19 Apr 2019 11:14:49 +0000 (UTC)
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay03.hostedemail.com (Postfix) with ESMTP id 70219837F27D;
        Fri, 19 Apr 2019 11:14:49 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: juice57_468155df5e521
X-Filterd-Recvd-Size: 2906
Received: from XPS-9350 (unknown [162.249.177.49])
        (Authenticated sender: joe@perches.com)
        by omf20.hostedemail.com (Postfix) with ESMTPA;
        Fri, 19 Apr 2019 11:14:44 +0000 (UTC)
Message-ID: <e5f29ca9b6067fff9ea68cb25e15906659cd51ad.camel@perches.com>
Subject: Re: [PATCH] kdb: Get rid of broken attempt to print CCVERSION in
 kdb summary
From:   Joe Perches <joe@perches.com>
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     Douglas Anderson <dianders@chromium.org>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Jason Wessel <jason.wessel@windriver.com>,
        Christophe Leroy <christophe.leroy@c-s.fr>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Kees Cook <keescook@chromium.org>,
        kgdb-bugreport@lists.sourceforge.net,
        Johannes Weiner <hannes@cmpxchg.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Nicholas Mc Guire <hofrat@osadl.org>,
        Andrew Morton <akpm@linux-foundation.org>
Date:   Fri, 19 Apr 2019 04:14:27 -0700
In-Reply-To: <CAK7LNAQe2uaVfKee1F6R4siVvUSCMgSaYAnUQfz8MS5PeFqpGA@mail.gmail.com>
References: <20190323015227.245455-1-dianders@chromium.org>
         <CAK7LNARYMy2=viA1et9tZk409M=OSteD5D675oAKQEs6SG77HQ@mail.gmail.com>
         <20190416163034.3e642818ebf27ed6891c1981@linux-foundation.org>
         <CAK7LNAR4Ty8835sfo4HSvBsMCsV65mY2HOajFSY2TOYurmkFdw@mail.gmail.com>
         <20190418160651.40cb6a11186a6c6028e9d20d@linux-foundation.org>
         <CAK7LNAQe2uaVfKee1F6R4siVvUSCMgSaYAnUQfz8MS5PeFqpGA@mail.gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.30.1-1build1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2019-04-19 at 12:28 +0900, Masahiro Yamada wrote:
> Hi Joe,
> 
> Can you detect redundant Cc: by checkpatch?
> 
> Please see below in details.
> Thanks.

Yes, but I'm not sure why it's useful or necessary.
git send-email using some scripts elides duplicate email addresses
---
 scripts/checkpatch.pl | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index 1c421ac42b07..bedec83cb797 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -2688,6 +2688,19 @@ sub process {
 				$signatures{$sig_nospace} = 1;
 			}
 
+# Check for a cc: line with another signature -by: by the same author
+			if ($sig_nospace =~ /^cc:/) {
+				my $sig_email = substr($sig_nospace, 3);
+				foreach my $sig (sort keys %signatures) {
+					next if ($sig =~ /^cc:/);
+					$sig =~ s/^[^:]+://;
+					if ($sig eq $sig_email) {
+						WARN("BAD_SIGN_OFF",
+						     "Unnecessary CC: as there is another signature with the same name/email address\n" . $herecurr);
+					}
+				}
+			}
+
 # Check Co-developed-by: immediately followed by Signed-off-by: with same name and email
 			if ($sign_off =~ /^co-developed-by:$/i) {
 				if ($email eq $author) {


