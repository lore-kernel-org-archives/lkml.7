Return-Path: <SRS0=camR=ZD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E17C4C43331
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 02:59:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B46B8206B6
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 02:59:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="dmSbbkVE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726791AbfKKC7A (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 10 Nov 2019 21:59:00 -0500
Received: from mail-qt1-f194.google.com ([209.85.160.194]:37943 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726742AbfKKC7A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Nov 2019 21:59:00 -0500
Received: by mail-qt1-f194.google.com with SMTP id p20so14154323qtq.5
        for <linux-kernel@vger.kernel.org>; Sun, 10 Nov 2019 18:58:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=content-transfer-encoding:from:mime-version:subject:date:message-id
         :references:cc:in-reply-to:to;
        bh=65bhuoPgriNtBUE2R+ohrdrdN/rvxnp383N9kf00A4s=;
        b=dmSbbkVEbFq3Auqxd7cNVOfavGXhUuzR/jNDxWcpYZsb/q5otj5juiciqFQLs5h9zu
         ua8wpEmtXRG49V+5P/HRsP8O5U1OgNREa/hCWX85nLnyvR+pIvYWO8pyTnnOGgTgrPwg
         ytx7Ll+rB1zUqY22w/s3m4fbnn94LFpxK1s/YMhyHR0/q/DPboqWMsPIu+WhxBb4N1ej
         WiPWDyK9nT7cThdxDd0bn7yBFfsFaXJwjrGzb2J7IrhEl3XuWFfyzsOxt7J85W/iQChi
         73+Xuu5oCmnJfCcbRdhWgFfA3/8KENy2CKbN8AuXD/bjuJUZsyVREd+a/7dGd37Yy6cT
         jyDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:content-transfer-encoding:from:mime-version
         :subject:date:message-id:references:cc:in-reply-to:to;
        bh=65bhuoPgriNtBUE2R+ohrdrdN/rvxnp383N9kf00A4s=;
        b=eOj7JtRzwSe0I+JDGyYKoZpfnjx9yFWuMlEman2eFcYA5569ux+90uXliwDrrzetn8
         BmIdR1In5OIHuIwj5n1YZXxRTDXPUxpnISNfZEo3wOJQiwvrwjohwcnEXn2HJiqilTf1
         hQ0N9yXT5/sHM0vElz7YewhqRnD1pJHRdVp3do9n+gI4ilYJw4io79CKuR3piAG3sn9s
         OsxQWaKHgooekQbYD3cEbwmIvo/cWhSScdlgtDD1ohmLgnt6LoF1oAPgOJ90tOUg5MKc
         XuWCoUl1CADvoMDOUpsaDeOl1P4w0lyb0iClLgXqrhTyIUc2i8vDYtIQRIf8XDZ5quc7
         nzGQ==
X-Gm-Message-State: APjAAAXK9WV5qFWXIX0Ge+R/xDy6juPq2ccM2whGinOAf74Ys3rI3AxP
        wc5y7wx6qtoAuWquTxPekHIFDyd9FNCmgg==
X-Google-Smtp-Source: APXvYqzgxJuH1MyOEI2dRYJeUBelSt0rQZuJ56c5fwz39EZF78E2gj0SlimsTSCYTi0Z+TMmH4PwUw==
X-Received: by 2002:ac8:524a:: with SMTP id y10mr23155907qtn.325.1573441137896;
        Sun, 10 Nov 2019 18:58:57 -0800 (PST)
Received: from [192.168.1.183] (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id r80sm6465873qke.121.2019.11.10.18.58.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 10 Nov 2019 18:58:57 -0800 (PST)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
From:   Qian Cai <cai@lca.pw>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH v2 1/1] iommu/vt-d: Add Kconfig option to enable/disable scalable mode
Date:   Sun, 10 Nov 2019 21:58:56 -0500
Message-Id: <472617D4-1652-45FB-90A4-0D45766DB78B@lca.pw>
References: <20191109034039.27964-1-baolu.lu@linux.intel.com>
Cc:     Joerg Roedel <joro@8bytes.org>,
        David Woodhouse <dwmw2@infradead.org>, kevin.tian@intel.com,
        ashok.raj@intel.com, linux-kernel@vger.kernel.org,
        iommu@lists.linux-foundation.org, jacob.jun.pan@intel.com
In-Reply-To: <20191109034039.27964-1-baolu.lu@linux.intel.com>
To:     Lu Baolu <baolu.lu@linux.intel.com>
X-Mailer: iPhone Mail (17A878)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Nov 8, 2019, at 10:43 PM, Lu Baolu <baolu.lu@linux.intel.com> wrote:
>=20
> +config INTEL_IOMMU_SCALABLE_MODE_DEFAULT_ON
> +    prompt "Enable Intel IOMMU scalable mode by default"
> +    depends on INTEL_IOMMU
> +    help
> +      Selecting this option will enable the scalable mode if
> +      hardware presents the capability. If this option is not
> +      selected, scalable mode support could also be enabled
> +      by passing intel_iommu=3Dsm_on to the kernel.
> +

Does it also make sense to mention which hardware presents this capability o=
r how to check it?=
