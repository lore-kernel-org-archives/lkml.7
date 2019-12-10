Return-Path: <SRS0=jko7=2A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B94D8C43603
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 19:08:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F4CB20637
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 19:08:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="bI25uhsn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727708AbfLJTIl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Dec 2019 14:08:41 -0500
Received: from mail-qk1-f195.google.com ([209.85.222.195]:37014 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727652AbfLJTIl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Dec 2019 14:08:41 -0500
Received: by mail-qk1-f195.google.com with SMTP id m188so17417308qkc.4
        for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2019 11:08:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=content-transfer-encoding:from:mime-version:subject:date:message-id
         :references:cc:in-reply-to:to;
        bh=xHZoF8qtGvYH+o9PkkLoHC+ywTgARXqFC6m+2XnjOKg=;
        b=bI25uhsnJy0K/gOfHwnTaHl8J4s12l+pPKCjzEe68SKrdCnubBni7GaYFAHu7Tzh8N
         FWhxxyYRP1ZvTZhQIQ80ogf9zZ/A3HjTQiOc+Ozwch3VSGSKrb8Qyh0tq0nvzYDBGVPq
         1CxQDWFv9n9gjRKdnj4iVQbVhfnZgxKdsH4q00dwtEuO+p5YH4nooNyDmjaThaJdNT7N
         o6bwzkOi5Pd/MPXAEgAFNvAA8Qg2pQVgKbU3xKmqnmSOd8EhTPqXENHxVH/UfoMIpTY5
         BC2f1fLW6F8Nt0pz4BoPhIAcXm96bRIq+VJQDFLkTMENayAqWijvKnpxVREuRu3kMmti
         EgsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:content-transfer-encoding:from:mime-version
         :subject:date:message-id:references:cc:in-reply-to:to;
        bh=xHZoF8qtGvYH+o9PkkLoHC+ywTgARXqFC6m+2XnjOKg=;
        b=aF1/X2X7dzRuilVOlfiVJjNq5X2JY+t87RopoiQQdJKV5pHZh9Q9tuu+vOZAHsn0GX
         DPTY5VfeLR8M05zxB7b6M3ou/sDTby98GPNeyCvBHBf9+gqRcT7Mro+jTz9zxsIFjqge
         8Am4YC2Wfw0QpZT7Sh3+S+ygnEHtcSh0YE70zORmtKAI5/hustnd9c1dmibv6joZS7FH
         sIUaBE8C6BGtB0yGYAvn/GRAVEDykvhkIvQ07riojdo8lDI2/Y/+1Rt/5lyOx5fzbItT
         ZQ/V9LjOYy+H905N5SXDoyClsGcbzU5kWCLg+HcXTpxaDPFftYQ7fgcikueDsBI/MiSu
         FXdw==
X-Gm-Message-State: APjAAAUdXif5URGGfhQEnHHh8bx0dcYKUzH5eZbiRtthpkvhKnQsVZBE
        0e91kjr6/FXWFwCAY4t1vC1hNw==
X-Google-Smtp-Source: APXvYqxLSPtY6oOoEG0W6kbYDl7cytfp4xJjuF3H74qIUXtDmgC14NEGEG1rkRu+ZBsedUTjB26RKA==
X-Received: by 2002:a37:ac16:: with SMTP id e22mr19638217qkm.186.1576004920008;
        Tue, 10 Dec 2019 11:08:40 -0800 (PST)
Received: from [192.168.1.183] (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id v2sm1212684qkj.29.2019.12.10.11.08.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Dec 2019 11:08:39 -0800 (PST)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
From:   Qian Cai <cai@lca.pw>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH] x86/resctrl: fix an imbalance in domain_remove_cpu
Date:   Tue, 10 Dec 2019 14:08:38 -0500
Message-Id: <35666437-F8AF-4170-A00F-79C34370BEF0@lca.pw>
References: <37341135-a0db-6d1c-236f-e32461b4c398@intel.com>
Cc:     Ryan Chen <yu.chen.surf@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Fenghua Yu <fenghua.yu@intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        John Stultz <john.stultz@linaro.org>, sboyd@kernel.org,
        Tony Luck <tony.luck@intel.com>, tj@kernel.org,
        the arch/x86 maintainers <x86@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <37341135-a0db-6d1c-236f-e32461b4c398@intel.com>
To:     Reinette Chatre <reinette.chatre@intel.com>
X-Mailer: iPhone Mail (17B111)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Dec 10, 2019, at 1:44 PM, Reinette Chatre <reinette.chatre@intel.com> w=
rote:
>=20
>=20
> "A system that supports resource monitoring may have multiple resources
> while not all of these resources are capable of monitoring. Monitoring
> related state is initialized only for resources that are capable of
> monitoring and correspondingly this state should subsequently only be
> removed from these resources that are capable of monitoring.
>=20
> domain_add_cpu() calls domain_setup_mon_state() only when r->mon_capable
> is true where it will initialize d->mbm_over. However,
> domain_remove_cpu() calls cancel_delayed_work(&d->mbm_over) without
> checking r->mon_capable resulting in an attempt to cancel d->mbm_over on
> all resources, even those that never initialized d->mbm_over because
> they are not capable of monitoring. Hence, it triggers a debugobjects
> warning when offlining CPUs because those timer debugobjects are never
> initialized.
>=20
> ODEBUG:..."

Looks better to me. Do you want me to send a v2 for it or you could update i=
t for merging?=
