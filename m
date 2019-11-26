Return-Path: <SRS0=8t7v=ZS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61BA5C432C0
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Nov 2019 20:28:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 33D8D20863
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Nov 2019 20:28:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CBhYcMif"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727016AbfKZU2a (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Nov 2019 15:28:30 -0500
Received: from mail-oi1-f194.google.com ([209.85.167.194]:39754 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726049AbfKZU23 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Nov 2019 15:28:29 -0500
Received: by mail-oi1-f194.google.com with SMTP id v138so17922919oif.6
        for <linux-kernel@vger.kernel.org>; Tue, 26 Nov 2019 12:28:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/XSZa4W/M2aE/Tb/1KifHz0unDdEO/TbPc4sPZEojwc=;
        b=CBhYcMifwObV8FiaLv3qnDm8tmxQesbOiKmpfYuLwQcoURmaoskF1BM3VvvuJsOxEg
         FeS4PEx1RfrQfekKtivjkgF7pV4uIh0nmFJIkzU+WBK1uEM80zbJa80xMaETFFZjGlva
         4jz3NvIlnC3RdVDU0YgJOoe+Ksz95PefmhbLQK2Er0F5wZZXWu1YtF8I64NxENNF3vG9
         f4F3WKam+EMzAwKbkar25ZPTlk/l3cK0HaHyZUbAJsyZaSckG4r44N/f88GEKvx4k8NE
         Kxv+bW0pCp6LKZVFQriQBDAFdj6bVkWKsjR52Mu1HC/KAImOfK+rNMbhfqVdA2byccjd
         3KLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/XSZa4W/M2aE/Tb/1KifHz0unDdEO/TbPc4sPZEojwc=;
        b=Qg8kF4G75p3qtsG+5Gjq+xyyQSYqY0hW6BG7gTi7Q8Q/mE46jvEDAdskG7a8R+CVa6
         QsqzikjPyQTe0XFurfO+6x1hoRisLUccm3BlKdYev3oikWB0LsJCY7PCJIjl7A6izmfD
         V74eu1SzImJsUW9JgXle4BfugZg/tpZHHYdovano4iYzpGzbT5BpOyXM5BJOceR3QKju
         IWX//yRc08UQRiNc6IRDk/op+AH2VudA/vlFS6TDrq6rtB/xbhlJ0ZdPTP2+tn1cqWX4
         WhEeCcYMKSAHt79qDCHxyT0e6hl5OBKltv6Pz+I6baSaREnQ9i4YOZWS0U5KoefhXBry
         XdPw==
X-Gm-Message-State: APjAAAXA7vzLLbpTskClm0VPqxRiwB6C05Yl1x+VdnNlz7yrxZdfMDxh
        +lSttDYbD+WMxw1sHQfU253jKNs+ircOesnKlR0t1g==
X-Google-Smtp-Source: APXvYqwYoqI9ebTNGSoRQFaPjS4xFGjozMV1PMYVPuvzl4n6+yfP1MFkD0UBucO5QOZTVwhOiGWpwNsqbdfl5iQJkQ4=
X-Received: by 2002:a05:6808:611:: with SMTP id y17mr814072oih.24.1574800108635;
 Tue, 26 Nov 2019 12:28:28 -0800 (PST)
MIME-Version: 1.0
References: <20191121114918.2293-1-will@kernel.org> <20191121114918.2293-10-will@kernel.org>
 <5c91d467-5e59-482b-8f4f-e0cfa3db9028@huawei.com>
In-Reply-To: <5c91d467-5e59-482b-8f4f-e0cfa3db9028@huawei.com>
From:   Saravana Kannan <saravanak@google.com>
Date:   Tue, 26 Nov 2019 12:27:52 -0800
Message-ID: <CAGETcx8Hkta6scFdiG=eQypsQ--jrR1YisaOQATCbMiu+aG8sg@mail.gmail.com>
Subject: Re: [PATCH v3 09/14] iommu/arm-smmu: Prevent forced unbinding of Arm
 SMMU drivers
To:     John Garry <john.garry@huawei.com>
Cc:     Will Deacon <will@kernel.org>, iommu@lists.linuxfoundation.org,
        LKML <linux-kernel@vger.kernel.org>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        Jordan Crouse <jcrouse@codeaurora.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Isaac J. Manjarres" <isaacm@codeaurora.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Joerg Roedel <joro@8bytes.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 26, 2019 at 1:13 AM John Garry <john.garry@huawei.com> wrote:
>
> On 21/11/2019 11:49, Will Deacon wrote:
> > Forcefully unbinding the Arm SMMU drivers is a pretty dangerous operation,
> > since it will likely lead to catastrophic failure for any DMA devices
> > mastering through the SMMU being unbound. When the driver then attempts
> > to "handle" the fatal faults, it's very easy to trip over dead data
> > structures, leading to use-after-free.
> >
> > On John's machine, he reports that the machine was "unusable" due to
> > loss of the storage controller following a forced unbind of the SMMUv3
> > driver:
> >
> >    | # cd ./bus/platform/drivers/arm-smmu-v3
> >    | # echo arm-smmu-v3.0.auto > unbind
> >    | hisi_sas_v2_hw HISI0162:01: CQE_AXI_W_ERR (0x800) found!
> >    | platform arm-smmu-v3.0.auto: CMD_SYNC timeout at 0x00000146
> >    | [hwprod 0x00000146, hwcons 0x00000000]
> >
> > Prevent this forced unbinding of the drivers by setting "suppress_bind_attrs"
> > to true.
>
> This seems a reasonable approach for now.
>
> BTW, I'll give this series a spin this week, which again looks to be
> your iommu/module branch, excluding the new IORT patch.

Is this on a platform where of_devlink creates device links between
the iommu device and its suppliers? I'm guessing no? Because device
links should for unbinding of all the consumers before unbinding the
supplier.

Looks like it'll still allow the supplier to unbind if the consumers
don't allow unbinding. Is that the case here?

-Saravana
