Return-Path: <SRS0=uTOJ=ST=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2422DC282DA
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 18:54:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E5875206BA
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 18:54:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CgOJ+XQ7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733300AbfDQSyM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Apr 2019 14:54:12 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:47053 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727340AbfDQSyM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Apr 2019 14:54:12 -0400
Received: by mail-pl1-f196.google.com with SMTP id y6so12429335pll.13
        for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2019 11:54:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=YrX+1I1HrFlav/Mjd3QOHrpWeZGt8dw7Qa8rQLOMVaU=;
        b=CgOJ+XQ7DbB8pi9Gmk4dGhcuODKQnBsi+TaJR4BYVHKQ5Ir1FnMiC2EjAZ4rbVphrf
         /Ro1JNCHpXvqW4sh0sm/0kjiiqk7ifHK/U+Xq3dhmPjDDUCNQ072tznQ469SvgNfNM87
         0mHRYXRsdhPKrXBE5d4G1chu/y0awPi1pTIukaBZLeEUuSvev1f6iMieqrWrhLb0E2ba
         CdcFIDyCgoh34MXc3kePv2FlzB7of/MNd2KxrzK+fcIkIF3ZGWD2muLcav2gCJPMic1B
         IMPJEu++xbcN328ajBM4CYSUdFYpU7TMwXPP3l6s6sMrI3gYIyChnyXnC42S+sR8rVsR
         R2Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=YrX+1I1HrFlav/Mjd3QOHrpWeZGt8dw7Qa8rQLOMVaU=;
        b=AHcGE7QBJiumCIKq0aFjHw4cajVAlD0NiOGau+cl04bZMTPb9hr1YZ4eQtIJmuqA9I
         inOuzC7MCmP4fuxM3Ro91GzsgxJ2oFnZWZjgWBJ3gJCX5f8EOprdSwwT+CLtVtwi86qO
         rUHd+ncZNDIv/TEvI/MgltS257WEoqntMAgOCeaUyCmyw2voGNohgZb7smJqxSWlgyaa
         POrKGs6B8ACfqppFLfwuSuD22m2i4CH5i5lm7zHY7/IBSwgoSwn5pGc+khrglLmm6jv0
         0hxNXfQfoSPWv1YEYlik0YRaOh63wSRwdaA57OWvmnstT7tdBElQRSThHc3Tsf1tF1BU
         GlyA==
X-Gm-Message-State: APjAAAWGEv+inWsC6QFXR+3H9kyLx38xoG/f6KsSNsehuG7azH8T8bUO
        DYrqtLkqGTRhsHzJlzhpDxk=
X-Google-Smtp-Source: APXvYqyDqtzrJqTSKa9vYrv5F6wBVWkc3VSCZ+eyvMf+o1Hl6MQ7/Wmum4kg3qouyDH2V+MBEd/e4w==
X-Received: by 2002:a17:902:2907:: with SMTP id g7mr54314052plb.238.1555527251698;
        Wed, 17 Apr 2019 11:54:11 -0700 (PDT)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.250])
        by smtp.gmail.com with ESMTPSA id j62sm63453001pfg.6.2019.04.17.11.54.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 17 Apr 2019 11:54:11 -0700 (PDT)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     bcm-kernel-feedback-list@broadcom.com,
        Markus Mayer <code@mmayer.net>,
        Brian Norris <computersforpeace@gmail.com>,
        Gregory Fong <gregory.0xf0@gmail.com>
Cc:     Markus Mayer <mmayer@broadcom.com>,
        ARM Kernel List <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 3/6] memory: brcmstb: dpfe: wait for DCPU to be ready
Date:   Wed, 17 Apr 2019 11:54:09 -0700
Message-Id: <20190417185409.1085-1-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190402230103.25491-4-code@mmayer.net>
References: <20190402230103.25491-1-code@mmayer.net> <20190402230103.25491-4-code@mmayer.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue,  2 Apr 2019 16:01:00 -0700, Markus Mayer <code@mmayer.net> wrote:
> From: Markus Mayer <mmayer@broadcom.com>
> 
> We wait for the DCPU to be ready before sending a command.
> 
> Signed-off-by: Markus Mayer <mmayer@broadcom.com>
> ---

Applied to drivers/next, thanks!
--
Florian
