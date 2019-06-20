Return-Path: <SRS0=KBKa=UT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FE46C43613
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 17:23:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 64D442089C
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 17:23:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1561051418;
	bh=DlXbYY5lg6tTGHYtR+WQoVTv37/TdMSpXgZmCCuTmb0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=vPepQa0XnqlwzVXxjQuW6tXUlbA2JpybZKpJtlMahfq/lX8D3pw5FLw9C1x7ioTBw
	 ZxL4qAAZBGOJDQfwjv+uRvLzIeQ4cH+lA6LiqOCvAC3W6h6fzYNCisSamE0sKAZBar
	 supIQA0TEpW9TwLoax2g7ti/VIXL79tI4cWR+CqE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732267AbfFTRXc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Jun 2019 13:23:32 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:52560 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732139AbfFTRXT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jun 2019 13:23:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=f7XUa/lQlxySmEWEcJcuTSMuU+ZsEK8Uqolu3z7EFDA=; b=gPLTIfM4lTx7UaT2ACxhgU/ngY
        R8VEmJDveFeVdJ1NSGlHeE+wnhF5tIcV9S23NSu6mn955GEM+1crbTdxUt0u0NsNBuIgsWBOMgpRu
        wh9vN1AgKyIbtOHjbbTJ3tC+oJFpbYCwx4IKvbyx9fObew456Uu7+CXXIav2QbvW419Tzh6C9M1Zj
        /J113+FbfmVAk+H6f5eSOm9qh/3MMoW812r4qiWAH/0cwAs2vj1ROgKNopIbj5N/n9Zswd1S6EE/z
        4WxPKdxMpr6ZJ5ojojEM8mSDNEGlbRx8iyrpjNjTjQ0YG9A41tQNEPJbKF4L5byehzgoKB1VCm9LU
        SJ4+n5Pw==;
Received: from [177.97.20.138] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1he0mM-0008S2-AX; Thu, 20 Jun 2019 17:23:18 +0000
Received: from mchehab by bombadil.infradead.org with local (Exim 4.92)
        (envelope-from <mchehab@bombadil.infradead.org>)
        id 1he0mJ-0000DG-PY; Thu, 20 Jun 2019 14:23:15 -0300
From:   Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Mauro Carvalho Chehab <mchehab@infradead.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>
Subject: [PATCH v2 10/22] scripts/get_abi.pl: avoid creating duplicate names
Date:   Thu, 20 Jun 2019 14:23:02 -0300
Message-Id: <23c67f22ebdf43b3cf17798e451311871841a0df.1561050806.git.mchehab+samsung@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <cover.1561050806.git.mchehab+samsung@kernel.org>
References: <cover.1561050806.git.mchehab+samsung@kernel.org>
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

