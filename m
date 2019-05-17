Return-Path: <SRS0=M1fl=TR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B7F7C04AB4
	for <linux-kernel@archiver.kernel.org>; Fri, 17 May 2019 06:33:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B3C020833
	for <linux-kernel@archiver.kernel.org>; Fri, 17 May 2019 06:33:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kmcGs7Fu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727986AbfEQGdq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 May 2019 02:33:46 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:45130 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727151AbfEQGdp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 May 2019 02:33:45 -0400
Received: by mail-pg1-f196.google.com with SMTP id i21so2789979pgi.12
        for <linux-kernel@vger.kernel.org>; Thu, 16 May 2019 23:33:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=bb7Nb+AcbwIXHUOUSIxjLWvCQysIpMmSZQ55rBSyD7c=;
        b=kmcGs7FucekfoRndFFOul65z4dL19N2BqPypshL0hr0Q+9BFBRZ7Gh4vR+y/GwpGi2
         qQfNAQBWCIa0xTNp4BxRz23bTCPuumdjOM2J/xQjFnMlVrRr5G40/wPP/eXUG2J+HAvz
         6fOYeETAcc6J2V0CpIJQ0NWgYbyUOjBuUWM7bhCW610za3Y6R3yoWSjJThMluYWoN2eb
         RQgGYZ8B3sR2eXi/6mMCirwQvnNEXlB7MH99cXloqJdDzhop6ViEhd/Kberlcy9s8rDG
         g8bVQA8PduVwOFinlWsGndF7PlEEaYT5KXiHw7FfZH1Fe9g+WOx+5FOz5QczzmjapUwe
         2HWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=bb7Nb+AcbwIXHUOUSIxjLWvCQysIpMmSZQ55rBSyD7c=;
        b=bMjCnEu/xYLoHV5coaM/2bcsh5bzFVs7TryrThDYxcv3mOyqBRgFuaMYdWU+2ILKVo
         ZsnoG2fNJnZRASlXXksIxZEIM60fadgtiqpohIice51pVWKBQligu0wsBGMnu072HDOq
         uPTmuwj4qM+c7RiWuNmLChs3i6qAlrBvGvGX7Jw6h6P9mOr8r/AOswGJBPQVEL0KeNOt
         BifrsJI03dBXcwqfHy9mn7JUFxmkborWnaVQRnhhxwtxJZHBm5+INTsOfl66XtcjJsWv
         yl0vlGz81OGuHaQMIDZ4yw0vzQnLw7lRadgcc1Ug6J2nGnt3VoeBSJ9oQNWVCxvGiXqk
         CMww==
X-Gm-Message-State: APjAAAXb3Q0+cYNAW0EMN8ZsIZD33pjEBvUnBzhRHjNupGVj9qhnzrqv
        B3L8Q8DvefAhVZrhWPTAZRQf69Bq3h4=
X-Google-Smtp-Source: APXvYqwbIwGH3Zd/XBNcH3jkrsyPtR2Jd9SP/u1Fma1//sQIHCTphFBe1bEEZJcz5VXI0mdZDoN0YA==
X-Received: by 2002:a63:18e:: with SMTP id 136mr26308725pgb.277.1558074825154;
        Thu, 16 May 2019 23:33:45 -0700 (PDT)
Received: from hydra-Latitude-E5440.qualcomm.com (blr-bdr-fw-01_globalnat_allzones-outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id d15sm22666897pfm.186.2019.05.16.23.33.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 16 May 2019 23:33:44 -0700 (PDT)
From:   parna.naveenkumar@gmail.com
To:     perex@perex.cz, tiwai@suse.com
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        Naveen Kumar Parna <parna.naveenkumar@gmail.com>
Subject: [PATCH] sound: open brace should be on the previous line
Date:   Fri, 17 May 2019 12:03:28 +0530
Message-Id: <20190517063328.21512-1-parna.naveenkumar@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Naveen Kumar Parna <parna.naveenkumar@gmail.com>

Resolved open brace { should be on the previous line checkpatch.pl
error. While addressing this error, also corrected the affected code
for below mentioned checkpatch errors.

ERROR: spaces required around that '<' (ctx:VxV)
ERROR: spaces required around that '==' (ctx:VxV)
ERROR: space required before the open parenthesis '('

Signed-off-by: Naveen Kumar Parna <parna.naveenkumar@gmail.com>
---
 sound/sound_core.c | 21 +++++++--------------
 1 file changed, 7 insertions(+), 14 deletions(-)

diff --git a/sound/sound_core.c b/sound/sound_core.c
index 40ad000c2e3c..ce794a2afc6b 100644
--- a/sound/sound_core.c
+++ b/sound/sound_core.c
@@ -111,8 +111,7 @@ module_exit(cleanup_soundcore);
 
 #define SOUND_STEP 16
 
-struct sound_unit
-{
+struct sound_unit {
 	int unit_minor;
 	const struct file_operations *unit_fops;
 	struct sound_unit *next;
@@ -151,8 +150,7 @@ module_param(preclaim_oss, int, 0444);
 
 static int soundcore_open(struct inode *, struct file *);
 
-static const struct file_operations soundcore_fops =
-{
+static const struct file_operations soundcore_fops = {
 	/* We must have an owner or the module locking fails */
 	.owner	= THIS_MODULE,
 	.open	= soundcore_open,
@@ -173,8 +171,7 @@ static int __sound_insert_unit(struct sound_unit * s, struct sound_unit **list,
 		while (*list && (*list)->unit_minor<n)
 			list=&((*list)->next);
 
-		while(n<top)
-		{
+		while (n < top) {
 			/* Found a hole ? */
 			if(*list==NULL || (*list)->unit_minor>n)
 				break;
@@ -219,11 +216,9 @@ static int __sound_insert_unit(struct sound_unit * s, struct sound_unit **list,
  
 static struct sound_unit *__sound_remove_unit(struct sound_unit **list, int unit)
 {
-	while(*list)
-	{
+	while (*list) {
 		struct sound_unit *p=*list;
-		if(p->unit_minor==unit)
-		{
+		if (p->unit_minor == unit) {
 			*list=p->next;
 			return p;
 		}
@@ -528,8 +523,7 @@ static struct sound_unit *__look_for_unit(int chain, int unit)
 	struct sound_unit *s;
 	
 	s=chains[chain];
-	while(s && s->unit_minor <= unit)
-	{
+	while (s && s->unit_minor <= unit) {
 		if(s->unit_minor==unit)
 			return s;
 		s=s->next;
@@ -545,8 +539,7 @@ static int soundcore_open(struct inode *inode, struct file *file)
 	const struct file_operations *new_fops = NULL;
 
 	chain=unit&0x0F;
-	if(chain==4 || chain==5)	/* dsp/audio/dsp16 */
-	{
+	if (chain == 4 || chain == 5) {	/* dsp/audio/dsp16 */
 		unit&=0xF0;
 		unit|=3;
 		chain=3;
-- 
2.17.1

