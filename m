Return-Path: <SRS0=x0+x=RM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3446CC43381
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Mar 2019 22:03:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EB3A3206DF
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Mar 2019 22:03:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m++Qux3S"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726445AbfCIWDV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 9 Mar 2019 17:03:21 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:35476 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726348AbfCIWDU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Mar 2019 17:03:20 -0500
Received: by mail-pg1-f196.google.com with SMTP id e17so995456pgd.2
        for <linux-kernel@vger.kernel.org>; Sat, 09 Mar 2019 14:03:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=9/Qv4F+seVN6RSxhM2NtIByCO2qK2SD7nuXN6TEknSU=;
        b=m++Qux3SPZqK+PEkkPHSKv/3ZzB7HixQUN1dDQqneCciK/NKZp+ax6ezHycJHyY2Ud
         2mhMiYgGECOQN2K6ZZGGiFID2GJzlbeoQRuKTq56Pg8d5nlsydhf+8KAss7m8MMEJrm/
         jKKJokdViVqsh+O41T+JgOsrYFRxkkggdi4gnYbhdkJjfgO4mXxKkH0FKd04ykhbLgKN
         x/Y+Eq70iM9OF6v8lFcL8NUqNpEMrCsw78TO5ae8U0z1fyY1O3gdYUDY9A72vATMuOwx
         YIXlZXQQlmGPOkWkotkuAAbaNKh8DemZoHK1A+srJ0/p0+CsUMD26LkikvQLRO+3eEUc
         6zsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=9/Qv4F+seVN6RSxhM2NtIByCO2qK2SD7nuXN6TEknSU=;
        b=svDp6V0MBe4S6Dru9LnLLbxlu3VcFFauJjJ0Qn/ECrLPMJyosdSaJw9dmCaWFwmJNj
         i+NgKCBD4we1JSazTH3knrqtn5g7hgOL9O/PV0mbCfw+J5TM/nXMRxFnzzJakPc5UiUi
         T9/KY1oZGxnh6CERkOIma6OSXhBD3RhmLXV3CQCa+DIFI3R87KT1ztPhQ7+7QHuQjH8U
         aMLkdUUujHiWCaYAXskycwQXrpYDbe6Uvu8pIIrxHRcv50HhVVtxSJfADoqSJUFq27uJ
         bAKlFByNVbbfv1bH9QFXvG/Bzt+gIm1ziW+cOn3/Y4HSDUUudXyUQXT9YHmP08EM8d7Y
         SH8g==
X-Gm-Message-State: APjAAAXWn27Osudi1J6oO++x7mBy0T17J0RJnWNWJoToXJFRzhRxpDkf
        TBGwvIdonxpTuLt0KKrK1pw=
X-Google-Smtp-Source: APXvYqy739V3IF98eVI3cxsqiZG1RtACJTsBIejseqs0AWgIfoE5egCt042vF10XqnxaVs0OzorC7w==
X-Received: by 2002:a62:5687:: with SMTP id h7mr25566553pfj.198.1552168999957;
        Sat, 09 Mar 2019 14:03:19 -0800 (PST)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.250])
        by smtp.gmail.com with ESMTPSA id k12sm2178264pfk.109.2019.03.09.14.03.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 09 Mar 2019 14:03:19 -0800 (PST)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     bcm-kernel-feedback-list@broadcom.com,
        Markus Mayer <code@mmayer.net>,
        Brian Norris <computersforpeace@gmail.com>,
        Gregory Fong <gregory.0xf0@gmail.com>
Cc:     Markus Mayer <mmayer@broadcom.com>,
        ARM Kernel List <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/3] soc: brcmstb: dpfe: use msleep() over udelay()
Date:   Sat,  9 Mar 2019 14:03:17 -0800
Message-Id: <20190309220317.25928-1-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190212012443.21819-2-code@mmayer.net>
References: <20190212012443.21819-1-code@mmayer.net> <20190212012443.21819-2-code@mmayer.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 11 Feb 2019 17:24:41 -0800, Markus Mayer <code@mmayer.net> wrote:
> From: Markus Mayer <mmayer@broadcom.com>
> 
> To be more "scheduler friendly", we use msleep() rather than udelay()
> while we wait for the DCPU to respond.
> 
> Signed-off-by: Markus Mayer <mmayer@broadcom.com>
> ---

Applied to drivers/next, thanks!
--
Florian
