Return-Path: <SRS0=fWiu=Y6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C5EDC43331
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 22:48:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EE409217D7
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 22:48:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="IreTXyYz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732814AbfKFWsG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Nov 2019 17:48:06 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:41427 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726912AbfKFWsG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Nov 2019 17:48:06 -0500
Received: by mail-pg1-f195.google.com with SMTP id h4so68426pgv.8
        for <linux-kernel@vger.kernel.org>; Wed, 06 Nov 2019 14:48:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=e4ahwvwEenCW3Ssy97Go1KwhMTmop2CdID3ppVgbYFg=;
        b=IreTXyYzkcyCRUuEUBoIo9m1mKz28IIQSdPSFoqi+uqqHfkqGViv23VBDhGs1OsYra
         qQP4cYTXyZPbHCM4+142sFe37YyZFQDoaOl3XIzdt0A6sWejvp0EgytFgqkd/Ju6Jmf1
         Zalng+bdd0Wbjg7KYwZpQNF9MDmNcm80wTOJOvWiiZ/C+BVgklJHj9fijYhUrHtu/wR2
         1lhD+AUpRU5FedUIofnCYApIfTWe8b+cW7HHubnSOEVhoPe4xzUC905NII3Y48GvZmyj
         biq3EpJrRwue6J8Md3V+8SRCtOZuxt+Ly/L3dyQSWd/JQksp6xvBGaLD6zzsErsXlDMc
         Q33A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=e4ahwvwEenCW3Ssy97Go1KwhMTmop2CdID3ppVgbYFg=;
        b=uN014YqwAmfIpRiUmUusyywM3lLA/rJ7exiDO7i+S4gId9jE7+EiGCP1KwZeXV0iEv
         98UtWRElumpZRPC42gZJrBljODCavOqRGOAdtOBSyXR+N9GhFRadqTzN5TrvCbco2ueh
         X93owYBMXGrsQUfcDauleNBw+3VXeZeDFjwV90jrYS1oyohFvEM4iLosstU76m3PL4zn
         tMiL3fK2IPVB+nFktuhD1oecVyighfcyH3ggaUT3G9naxO+tCHAPdwCVGM7gFSp9orQq
         da/h/CndW8r8YVumN0kcKvyJysyvZYcVsHuiCaBMRQEEPvcz8aAEPUUvp1Gk0gjy9OFW
         4tIw==
X-Gm-Message-State: APjAAAVLI6eoDCOaBwnS14iKdsvpPzCYDOrsfvkHOTsFBR2dhTmIfNV5
        DLfSj5DMn31Dzk8saoE34joYGw==
X-Google-Smtp-Source: APXvYqyr+y0D1jq1rNuNO65CIHswePbMJN08xlpb8XRXVBMMBoJvb6+TV4m3ywBKKJveiNntlfYEBg==
X-Received: by 2002:a63:395:: with SMTP id 143mr325134pgd.93.1573080485690;
        Wed, 06 Nov 2019 14:48:05 -0800 (PST)
Received: from localhost ([12.206.222.5])
        by smtp.gmail.com with ESMTPSA id o1sm112685pgm.1.2019.11.06.14.48.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Nov 2019 14:48:04 -0800 (PST)
Date:   Wed, 6 Nov 2019 14:48:04 -0800 (PST)
From:   Paul Walmsley <paul.walmsley@sifive.com>
X-X-Sender: paulw@viisi.sifive.com
To:     Zong Li <zong.li@sifive.com>
cc:     linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        palmer@sifive.com
Subject: Re: [PATCH] riscv: clean up the macro format in each header file
In-Reply-To: <1572248567-22504-1-git-send-email-zong.li@sifive.com>
Message-ID: <alpine.DEB.2.21.9999.1911061423390.20606@viisi.sifive.com>
References: <1572248567-22504-1-git-send-email-zong.li@sifive.com>
User-Agent: Alpine 2.21.9999 (DEB 301 2018-08-15)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 28 Oct 2019, Zong Li wrote:

> There are many different formats in each header now, such as
> _ASM_XXX_H, __ASM_XXX_H, _ASM_RISCV_XXX_H, RISCV_XXX_H, etc., This patch
> tries to unify the format by using _ASM_RISCV_XXX_H, because the most
> header use it now. This patch also adds the conditional to the headers
> if they lost it.
> 
> Signed-off-by: Zong Li <zong.li@sifive.com>

Thanks, queued for v5.5-rc1.

- Paul
