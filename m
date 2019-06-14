Return-Path: <SRS0=TKbG=UN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B780C31E4B
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 17:53:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 134CE2183E
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 17:53:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1560534832;
	bh=DlXbYY5lg6tTGHYtR+WQoVTv37/TdMSpXgZmCCuTmb0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=HerUXV5k+Lb29vXb7soTcT4Wb5GgWPo6hndKCZBmF5O2hx5CiABzHKQJEtRH4XoeL
	 2FuFCcP77ZH/i11HZnR5UGLveWcTAXtOkza5BpQcf7+NfY60LpCpMhxPGv32P1RmyA
	 zIAfMB5off9Qc2+IikGTd+A9A91hQw6gS13JKYBk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727381AbfFNRxu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Jun 2019 13:53:50 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:38616 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726397AbfFNRwe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jun 2019 13:52:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=f7XUa/lQlxySmEWEcJcuTSMuU+ZsEK8Uqolu3z7EFDA=; b=Pp67UvWQoNL5haPkZ7R8Xthq8N
        QawMGfQ4+60R72PEbqX7B3+/DxjITPqAzR/ZnZvDOOLI0cX6yAo9TG84HvSBUmwBUJCfJrgjHw9KJ
        5j1IBek8OSO+l4sPBmyWxj8NbuJ8cFa9N6bUhkgo7Y8CQ0I+aUT3bo8sdICO6JbceS2j/34IqxqY7
        P1h9C57qyJ2XDB04CQCYmTBgx9uADJkiHodQomCwA7wO+aXxMPVY2FyoElJffUfGErL6B+Qg9+TPE
        MarrwVpeEh6ILKrMw3VFjX91PQJb1mZhkjAC+56GwozixSErKkPjSU8TlJZn7Gtc60kTVE2fLDBXb
        CL/DokfA==;
Received: from 177.133.85.52.dynamic.adsl.gvt.net.br ([177.133.85.52] helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hbqNO-0000PX-IZ; Fri, 14 Jun 2019 17:52:34 +0000
Received: from mchehab by bombadil.infradead.org with local (Exim 4.92)
        (envelope-from <mchehab@bombadil.infradead.org>)
        id 1hbqNL-0002P2-Ul; Fri, 14 Jun 2019 14:52:31 -0300
From:   Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Mauro Carvalho Chehab <mchehab@infradead.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>
Subject: [PATCH v2 10/16] scripts/get_abi.pl: avoid creating duplicate names
Date:   Fri, 14 Jun 2019 14:52:24 -0300
Message-Id: <23c67f22ebdf43b3cf17798e451311871841a0df.1560534648.git.mchehab+samsung@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <3b8d7c64f887ddea01df3c4eeabc745c8ec45406.1560534648.git.mchehab+samsung@kernel.org>
References: <3b8d7c64f887ddea01df3c4eeabc745c8ec45406.1560534648.git.mchehab+samsung@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The file the Documentation/ABI/testing/sysfs-class-power has
voltage_min, voltage_max and voltage_now symbols duplicated.

They are defined first for "General Properties" and then for
"USB Properties".

This cause those warnings:

	get_abi.pl rest --dir $srctree/Documentation/ABI/testing:26933: WARNING: Duplicate explicit target name: "abi_sys_class_power_supply_supply_name_voltage_max".
	get_abi.pl rest --dir $srctree/Documentation/ABI/testing:26968: WARNING: Duplicate explicit target name: "abi_sys_class_power_supply_supply_name_voltage_min".
	get_abi.pl rest --dir $srctree/Documentation/ABI/testing:27008: WARNING: Duplicate explicit target name: "abi_sys_class_power_supply_supply_name_voltage_now".

And, as the references are not valid, it will also generate
warnings about links to undefined references.

Fix it by storing labels into a hash table and, when a duplicated
one is found, appending random characters at the end.

Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
---
 scripts/get_abi.pl | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/scripts/get_abi.pl b/scripts/get_abi.pl
index 116f0c33c16d..329ace635ac2 100755
--- a/scripts/get_abi.pl
+++ b/scripts/get_abi.pl
@@ -194,6 +194,8 @@ sub parse_abi {
 # Outputs the book on ReST format
 #
 
+my %labels;
+
 sub output_rest {
 	foreach my $what (sort {
 				($data{$a}->{type} eq "File") cmp ($data{$b}->{type} eq "File") ||
@@ -217,6 +219,13 @@ sub output_rest {
 			$label =~ s,_+,_,g;
 			$label =~ s,_$,,;
 
+			# Avoid duplicated labels
+			while (defined($labels{$label})) {
+			    my @chars = ("A".."Z", "a".."z");
+			    $label .= $chars[rand @chars];
+			}
+			$labels{$label} = 1;
+
 			$data{$what}->{label} .= $label;
 
 			printf ".. _%s:\n\n", $label;
-- 
2.21.0

