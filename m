Return-Path: <SRS0=19dG=ZH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC2ECC432C3
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 22:23:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8406520733
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 22:23:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="nU5W/+Iy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727112AbfKOWX1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Nov 2019 17:23:27 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:39420 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726766AbfKOWX1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Nov 2019 17:23:27 -0500
Received: by mail-pl1-f195.google.com with SMTP id o9so5608905plk.6
        for <linux-kernel@vger.kernel.org>; Fri, 15 Nov 2019 14:23:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=message-id:mime-version:content-transfer-encoding:in-reply-to
         :references:cc:to:subject:from:user-agent:date;
        bh=yppwufp6fi68L6zC976bP2MDCDwalyA413IHzRLTRlY=;
        b=nU5W/+IyG98AxdUwHyf+wLywGa5TnF7Ai0NmHUxUTs4Rb8mMjLKWjb8Fh5+VprN3DU
         V+2cLvHSZv0bleZyU3hQ6Rw5+EY++Ytg1twvL14duo5hKv64vSPp3xonFA/g20jaLD2O
         ZvbBklGWeKej0ztEwQFh4h9GWvCjuRSzvoMdc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:mime-version
         :content-transfer-encoding:in-reply-to:references:cc:to:subject:from
         :user-agent:date;
        bh=yppwufp6fi68L6zC976bP2MDCDwalyA413IHzRLTRlY=;
        b=d7Ks9Doif9nEkmzSSEz3GHZhjrPvpmohuSstlK0jwivwFxyRtdtqnDvoS+ofC1PBBe
         XTh4/D/A517KJd0jCyCClLqKo/viTNQ+tJlQTLErRYikeHJE+muImPLorBKsDq9lIlz+
         lz3Dqgf2bMvgV9jt7W46ZmZV/kuAPk+vkzrv4u7gh9l9/ZLSRqo84sHq0oayTRxT7+ug
         cm0TISVWxnalx6Q+IN+RKdGIK0JCwWBPcLX/39QzG3BQCFaZXdUC/gQvi4VSniAoFEIG
         BdMiSP3Dc3eakIPM7iSNTXT4AzMibpfv9esmv/H7yNcFR6SZFSz8PJWR3u2u4JrGdfjq
         pX+g==
X-Gm-Message-State: APjAAAWu4L/Yx7BwdvXYimGMPbSeMZvMlCQP4cF5SVqG3GP61TZxdExA
        Yqm1lXmd14xptIpbrcuLsTcdKogf02U=
X-Google-Smtp-Source: APXvYqwc+Fxn32tFRsblEdXKRAGMh+OA8F86nEcqx11mQ98RO1d4HrGBRg3EzcRSBGr/RA2IO1b+Iw==
X-Received: by 2002:a17:90b:300c:: with SMTP id hg12mr23008139pjb.75.1573856606375;
        Fri, 15 Nov 2019 14:23:26 -0800 (PST)
Received: from chromium.org ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id i102sm11149578pje.17.2019.11.15.14.23.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Nov 2019 14:23:25 -0800 (PST)
Message-ID: <5dcf255d.1c69fb81.e4c8b.0c06@mx.google.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20191115161524.23738-1-patrick.rudolph@9elements.com>
References: <20191115161524.23738-1-patrick.rudolph@9elements.com>
Cc:     coreboot@coreboot.org,
        Patrick Rudolph <patrick.rudolph@9elements.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Allison Randal <allison@lohutok.net>,
        Alexios Zavras <alexios.zavras@intel.com>,
        Julius Werner <jwerner@chromium.org>,
        Samuel Holland <samuel@sholland.org>
To:     linux-kernel@vger.kernel.org, patrick.rudolph@9elements.com
Subject: Re: [PATCH 0/2] firmware: google: Expose coreboot tables and CBMEM
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.8.1
Date:   Fri, 15 Nov 2019 14:23:24 -0800
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting patrick.rudolph@9elements.com (2019-11-15 08:15:14)
> From: Patrick Rudolph <patrick.rudolph@9elements.com>
>=20
> As user land tools currently use /dev/mem to access coreboot tables and
> CBMEM, provide a better way by using sysfs attributes.
>=20
> Unconditionally expose all tables and buffers making future changes in
> coreboot possible without modifying a kernel driver.
>=20
> Patrick Rudolph (2):
>   firmware: google: Expose CBMEM over sysfs
>   firmware: google: Expose coreboot tables over sysfs
>=20
>  drivers/firmware/google/Kconfig          |   6 +
>  drivers/firmware/google/Makefile         |   1 +
>  drivers/firmware/google/cbmem-coreboot.c | 164 +++++++++++++++++++++++
>  drivers/firmware/google/coreboot_table.c |  59 ++++++++
>  drivers/firmware/google/coreboot_table.h |  13 ++

There should be some Documentation/ABI updates here too so we know how
the sysfs files work.

