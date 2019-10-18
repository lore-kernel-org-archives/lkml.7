Return-Path: <SRS0=6OEZ=YL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D90CECA9EA0
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 08:30:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B874021925
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 08:30:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2505050AbfJRIaR convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Oct 2019 04:30:17 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:38866 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406746AbfJRIaR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Oct 2019 04:30:17 -0400
Received: from mail-pl1-f200.google.com ([209.85.214.200])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <kai.heng.feng@canonical.com>)
        id 1iLNeK-0004ML-0u
        for linux-kernel@vger.kernel.org; Fri, 18 Oct 2019 08:30:16 +0000
Received: by mail-pl1-f200.google.com with SMTP id j9so3263565plk.21
        for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2019 01:30:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=9HnLyuAc2KszW2sCbnW2TVqDttn2ZhGYOZuSbcGb+Ao=;
        b=RkogPkFAoa1+KyhX/d1WLOR7Tw4BqNHO7k/RqmlDyYzuKMojgOhoADEC18rj4hMwka
         17lpHDASnWr0ZFmYf1ayru9v8TP9hcezabIOrkmLloKs4oZjQylvegQiYuCU099F/qxD
         4I6fuoycAMKekdgrdWwjAcRVjd0/utBsnjlGRrYBu4e+mOqY5hcKSTCKpWsDZ4My6UEp
         7Rz/Al6S3Oq0sSVwgVHt2jdRuZxN1zigwvFCkx+XjzYgaKD5emxwJtP9WYzU0Zodp0vU
         omEML8duYO5A1OilPlNprsEQ9lrPrlhvD7JY9V69as+8TAW7oM+obk4ROaAlyTSeTPNh
         kP9w==
X-Gm-Message-State: APjAAAU4gwpahY/DrOINpVx13j2uqyuC1wvtKXeBuJ5EuDCiZvhrFb0A
        APtnARFNzEL5MP65iF6poQ6/Z+wszWeit9xFSdLPYeM5Di7glj7tFqEpetjdC4wD9ug9XQuKCIo
        mbH4o+gxFDWrte+DAZqc90Nv801C3axuXdSvj0ifgdA==
X-Received: by 2002:a17:902:aa86:: with SMTP id d6mr8878183plr.268.1571387414555;
        Fri, 18 Oct 2019 01:30:14 -0700 (PDT)
X-Google-Smtp-Source: APXvYqx/HstgLPTWdbdqHW8QWIvwRL6LLMXn5En0TaPY+gU76l2aPXRwvWmgbm5PxCa/kgGW3UqDQg==
X-Received: by 2002:a17:902:aa86:: with SMTP id d6mr8878156plr.268.1571387414189;
        Fri, 18 Oct 2019 01:30:14 -0700 (PDT)
Received: from 2001-b011-380f-3c42-80b6-0157-ba58-fc96.dynamic-ip6.hinet.net (2001-b011-380f-3c42-80b6-0157-ba58-fc96.dynamic-ip6.hinet.net. [2001:b011:380f:3c42:80b6:157:ba58:fc96])
        by smtp.gmail.com with ESMTPSA id f185sm6882160pfb.183.2019.10.18.01.30.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 18 Oct 2019 01:30:13 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.0 \(3601\))
Subject: Re: [PATCH v6 1/2] PCI: Add a helper to check Power Resource
 Requirements _PR3 existence
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
In-Reply-To: <s5hr23ah3g9.wl-tiwai@suse.de>
Date:   Fri, 18 Oct 2019 16:30:11 +0800
Cc:     bhelgaas@google.com, linux-pci@vger.kernel.org,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8BIT
Message-Id: <4C18DF4A-FAE8-4762-AF65-F892A4845297@canonical.com>
References: <20191018073848.14590-1-kai.heng.feng@canonical.com>
 <s5hr23ah3g9.wl-tiwai@suse.de>
To:     Takashi Iwai <tiwai@suse.de>
X-Mailer: Apple Mail (2.3601)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Oct 18, 2019, at 16:18, Takashi Iwai <tiwai@suse.de> wrote:
> 
> On Fri, 18 Oct 2019 09:38:47 +0200,
> Kai-Heng Feng wrote:
>> 
>> A driver may want to know the existence of _PR3, to choose different
>> runtime suspend behavior. A user will be add in next patch.
>> 
>> This is mostly the same as nouveau_pr3_present().
>> 
>> Reported-by: kbuild test robot <lkp@intel.com>
> 
> It's confusing -- this particular change isn't reported by the test
> bot, but only about the lack of the CONFIG_ACPI ifdef.

Hmm, because the test bot asked to add the tag.
If it's not appropriate will you drop it? I can also send a v7.

Kai-Heng

> 
> 
> thanks,
> 
> Takashi
> 
>> Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
>> ---
>> v6:
>> - Only define the function when CONFIG_ACPI is set.
>> v5:
>> - Add wording suggestion from Bjorn.
>> v4:
>> - Let caller to find its upstream port device.
>> 
>> drivers/pci/pci.c   | 18 ++++++++++++++++++
>> include/linux/pci.h |  2 ++
>> 2 files changed, 20 insertions(+)
>> 
>> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
>> index e7982af9a5d8..1df99d9e350e 100644
>> --- a/drivers/pci/pci.c
>> +++ b/drivers/pci/pci.c
>> @@ -5856,6 +5856,24 @@ int pci_set_vga_state(struct pci_dev *dev, bool decode,
>> 	return 0;
>> }
>> 
>> +#ifdef CONFIG_ACPI
>> +bool pci_pr3_present(struct pci_dev *pdev)
>> +{
>> +	struct acpi_device *adev;
>> +
>> +	if (acpi_disabled)
>> +		return false;
>> +
>> +	adev = ACPI_COMPANION(&pdev->dev);
>> +	if (!adev)
>> +		return false;
>> +
>> +	return adev->power.flags.power_resources &&
>> +		acpi_has_method(adev->handle, "_PR3");
>> +}
>> +EXPORT_SYMBOL_GPL(pci_pr3_present);
>> +#endif
>> +
>> /**
>>  * pci_add_dma_alias - Add a DMA devfn alias for a device
>>  * @dev: the PCI device for which alias is added
>> diff --git a/include/linux/pci.h b/include/linux/pci.h
>> index f9088c89a534..1d15c5d49cdd 100644
>> --- a/include/linux/pci.h
>> +++ b/include/linux/pci.h
>> @@ -2310,9 +2310,11 @@ struct irq_domain *pci_host_bridge_acpi_msi_domain(struct pci_bus *bus);
>> 
>> void
>> pci_msi_register_fwnode_provider(struct fwnode_handle *(*fn)(struct device *));
>> +bool pci_pr3_present(struct pci_dev *pdev);
>> #else
>> static inline struct irq_domain *
>> pci_host_bridge_acpi_msi_domain(struct pci_bus *bus) { return NULL; }
>> +static bool pci_pr3_present(struct pci_dev *pdev) { return false; }
>> #endif
>> 
>> #ifdef CONFIG_EEH
>> -- 
>> 2.17.1
>> 

