Return-Path: <SRS0=bo2+=SE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC52DC43381
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 02:51:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 985AF2070D
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 02:51:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PAuhiXAF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728981AbfDBCvp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 22:51:45 -0400
Received: from mail-it1-f194.google.com ([209.85.166.194]:35705 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726269AbfDBCvp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 22:51:45 -0400
Received: by mail-it1-f194.google.com with SMTP id w15so2769571itc.0
        for <linux-kernel@vger.kernel.org>; Mon, 01 Apr 2019 19:51:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=xUqoY2mk21wr1bmDLvvc2Vtwm8+AKUani48Dr7S8eig=;
        b=PAuhiXAFdHfSh7HImbu5gNwXKEDDvl6L9op2Rb772lyFyo8x9VPRpDrHgjDEFCUGB2
         fa96LqcpRnNt3zLS04DK8Q9fg9AbWo8NV4l9nTx6tiVyEkseJ1cQ3nK72LOdXf2A7lF6
         tSZqzLFfnWThXoUfv9g00x505hRva4YRsg0gtSuMQyvZgURwFTFtBc29XKnVH5Szbleo
         QoLcso5psH7sHyYJTOy/8usNhrwhrcVSMrIBIRsyE3msfDm90xhxZUbOBrRzbqwp4oC6
         JLPmW/APoJN6ZBMhf7OArdyseVUoOLasSMIlmRrIH1a9cx3Fh++yadOktPLd+15FLO5d
         6w3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=xUqoY2mk21wr1bmDLvvc2Vtwm8+AKUani48Dr7S8eig=;
        b=OIdmdiJ+38Svz6sY9bezQ03c135tA53u/vyaOMTZ3XNMc4lwdMXTSogwhK+hTQKSqK
         XgK68NPqnDW1P6w3hHzuuF3vQVsfVOfOsEMtxuGrGo9JttWi16sytc91da0n8er1Nhg2
         9lyoDVBRCwXDdMZFqkBd+8lxudnc3Ov7TLiGdPlIHSD4Ub4YhmFTNY/igtSQs+czpsNv
         dh7Kts3j4LzEoeKB5s6No+l4Qe2Bj+Omzcp4BlPqOVFUXjdsk0G6+wP2P2HZbeTr1GTe
         YbS/2+lamgY1BrPBiEWEIh1iSNyFv+cmCGi69JMLz9/a7JOno6kmULeBsmGeGtDNFms7
         7ddw==
X-Gm-Message-State: APjAAAVtB1sj5RZnnaoqaRyVz+k/k5VOI+qTMV5cBnNwfr+mK/3P2Lc0
        ZoFGPX/lfMxKN8k+Q8j7I8Q=
X-Google-Smtp-Source: APXvYqxNq9J/4VNQr8idQvVM66CRBmn3HON3lfvfxB+HKavLbZiOd/fUPhTgEDZoV24qWDlW+UoA6A==
X-Received: by 2002:a02:b38f:: with SMTP id p15mr26880024jan.103.1554173504241;
        Mon, 01 Apr 2019 19:51:44 -0700 (PDT)
Received: from ubu (2600-6c48-437f-c81d-984d-b4e8-0abe-7e26.dhcp6.chtrptr.net. [2600:6c48:437f:c81d:984d:b4e8:abe:7e26])
        by smtp.gmail.com with ESMTPSA id v20sm5231204ioh.17.2019.04.01.19.51.43
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 01 Apr 2019 19:51:43 -0700 (PDT)
Date:   Mon, 1 Apr 2019 22:51:41 -0400
From:   Kimberly Brown <kimbrownkd@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org
Subject: [PATCH v2 5/8] irqdesc: Replace irq_kobj_type's default_attrs field
 with groups
Message-ID: <67ed609340d94538992702131e94247eee24a0fd.1554151487.git.kimbrownkd@gmail.com>
References: <20190322201440.GA30814@ubu-Virtual-Machine>
 <cover.1554151487.git.kimbrownkd@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1554151487.git.kimbrownkd@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The kobj_type default_attrs field is being replaced by the
default_groups field. Replace irq_kobj_type's default_attrs field with
default_groups and use the ATTRIBUTE_GROUPS macro to create irq_groups.

This patch was tested by verifying that the sysfs files for the
attributes in the default groups were created.

Signed-off-by: Kimberly Brown <kimbrownkd@gmail.com>
---
 kernel/irq/irqdesc.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/irq/irqdesc.c b/kernel/irq/irqdesc.c
index 13539e12cd80..bbec57bda666 100644
--- a/kernel/irq/irqdesc.c
+++ b/kernel/irq/irqdesc.c
@@ -275,11 +275,12 @@ static struct attribute *irq_attrs[] = {
 	&actions_attr.attr,
 	NULL
 };
+ATTRIBUTE_GROUPS(irq);
 
 static struct kobj_type irq_kobj_type = {
 	.release	= irq_kobj_release,
 	.sysfs_ops	= &kobj_sysfs_ops,
-	.default_attrs	= irq_attrs,
+	.default_groups = irq_groups,
 };
 
 static void irq_sysfs_add(int irq, struct irq_desc *desc)
-- 
2.17.1

