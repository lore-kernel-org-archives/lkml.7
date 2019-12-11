Return-Path: <SRS0=Yvat=2B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A8DAC43603
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 22:47:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1861F21556
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 22:47:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ozlabs-ru.20150623.gappssmtp.com header.i=@ozlabs-ru.20150623.gappssmtp.com header.b="EbkgAO0L"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726879AbfLKWrk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Dec 2019 17:47:40 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:37031 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726463AbfLKWrj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Dec 2019 17:47:39 -0500
Received: by mail-pl1-f196.google.com with SMTP id c23so171944plz.4
        for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2019 14:47:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ozlabs-ru.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:autocrypt:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=DRK3VQsFS/9End2QZaKBJTCN+43qMGqEkn/JQq+oi+k=;
        b=EbkgAO0Lj2fEEUPof6lNGDQaiVJVC58bufWQ+FGVNU7hMbP4jR0z+LAGLfrrl5Ncuw
         GZZpNNWHKv7GNmOrguAFNVISJzCwS3kEBlIogzDa/01qF+wRtXt4hzAomEtZqNVrUfnb
         GTnr85lxtTc7NgsWFsvcEF+QWmKqPX9Mi8k/F0U2reoPDjv62T0Orw6ES4GmMEO4pUFW
         7PFULF8DOr1LvvAaQO+18B26y9LjnabIKaWFJLWFjzqVSElgmcRxdhPthjxmK3hCQJ9T
         V4UV9DFFyMvBAwR/cUJwS/VLrjp0st+sYW+IsErQK2Z78/gvB36XRMh8LFIBtkmftWwY
         lHVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=DRK3VQsFS/9End2QZaKBJTCN+43qMGqEkn/JQq+oi+k=;
        b=NfUduMz37iNQL/NxhP5jG8aUfRPdAOU9QT8VTq23fpPh4YO+2gZDljaRWLlb3BARST
         zQwiJkiNliFy6qcwF0k2aADLLw7PDlhpeaVkSRpO+jng2YeIgFIKB7yEJr6zhT18Bh3P
         te+BrRXbtaqnjgxftWrjVBqDkR1W52ufUuGV+IRkeUmTBL2tiV9lCWQ0CVIFb5q/TIlH
         2yVRF8F4wJqTHqCgMKTDZ6b9UVrfMjoM6juVeegJbezQRktSLyCt37hXSqadYj+HK8K+
         RSvxoDylcHv2PlBnSP/0XmtBJersysqmN+LYovoNYBX45M/L0ujDO5eBSs0E8Q3vUc53
         StkQ==
X-Gm-Message-State: APjAAAVMiEQhSQGoX5KEguvT0OoBzoC6b3zY/rzUQ92KRREWU9To7Y8c
        TiWUPqqBYwZKphgBtkDrIL4fbg==
X-Google-Smtp-Source: APXvYqyZYJroX4Ei7ctM7iN5eA+8DdrkafzD0r00cBtWtSO4tPP+ozuvlN6roMtOAKd3Duc5MDZQlg==
X-Received: by 2002:a17:902:ac8b:: with SMTP id h11mr6048284plr.87.1576104458458;
        Wed, 11 Dec 2019 14:47:38 -0800 (PST)
Received: from [10.61.2.175] ([122.99.82.10])
        by smtp.gmail.com with ESMTPSA id in19sm3395991pjb.11.2019.12.11.14.47.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Dec 2019 14:47:37 -0800 (PST)
Subject: Re: [PATCH v5 1/2] powerpc/pseries/iommu: Share the per-cpu TCE page
 with the hypervisor.
To:     Michael Roth <mdroth@linux.vnet.ibm.com>,
        Ram Pai <linuxram@us.ibm.com>
Cc:     mpe@ellerman.id.au, linuxppc-dev@lists.ozlabs.org,
        benh@kernel.crashing.org, david@gibson.dropbear.id.au,
        paulus@ozlabs.org, hch@lst.de, andmike@us.ibm.com,
        sukadev@linux.vnet.ibm.com, mst@redhat.com, ram.n.pai@gmail.com,
        cai@lca.pw, tglx@linutronix.de, bauerman@linux.ibm.com,
        linux-kernel@vger.kernel.org, leonardo@linux.ibm.com
References: <1575681159-30356-1-git-send-email-linuxram@us.ibm.com>
 <1575681159-30356-2-git-send-email-linuxram@us.ibm.com>
 <ed0f048c-bb40-c6c6-887c-ef68c9e411a2@ozlabs.ru>
 <20191210051244.GB5702@oc0525413822.ibm.com>
 <c4b48f55-e4e3-222a-0aa0-9b4783e19584@ozlabs.ru>
 <20191210153542.GB5709@oc0525413822.ibm.com>
 <90f6019b-d756-7f33-21b0-bb49c1c842da@ozlabs.ru>
 <157609629270.3810.9676234389583169255@sif>
From:   Alexey Kardashevskiy <aik@ozlabs.ru>
Autocrypt: addr=aik@ozlabs.ru; keydata=
 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
Message-ID: <ad63a352-bdec-08a8-2fd0-f64b9579da6c@ozlabs.ru>
Date:   Thu, 12 Dec 2019 09:47:30 +1100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <157609629270.3810.9676234389583169255@sif>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 12/12/2019 07:31, Michael Roth wrote:
> Quoting Alexey Kardashevskiy (2019-12-11 02:15:44)
>>
>>
>> On 11/12/2019 02:35, Ram Pai wrote:
>>> On Tue, Dec 10, 2019 at 04:32:10PM +1100, Alexey Kardashevskiy wrote:
>>>>
>>>>
>>>> On 10/12/2019 16:12, Ram Pai wrote:
>>>>> On Tue, Dec 10, 2019 at 02:07:36PM +1100, Alexey Kardashevskiy wrote:
>>>>>>
>>>>>>
>>>>>> On 07/12/2019 12:12, Ram Pai wrote:
>>>>>>> H_PUT_TCE_INDIRECT hcall uses a page filled with TCE entries, as one of
>>>>>>> its parameters.  On secure VMs, hypervisor cannot access the contents of
>>>>>>> this page since it gets encrypted.  Hence share the page with the
>>>>>>> hypervisor, and unshare when done.
>>>>>>
>>>>>>
>>>>>> I thought the idea was to use H_PUT_TCE and avoid sharing any extra
>>>>>> pages. There is small problem that when DDW is enabled,
>>>>>> FW_FEATURE_MULTITCE is ignored (easy to fix); I also noticed complains
>>>>>> about the performance on slack but this is caused by initial cleanup of
>>>>>> the default TCE window (which we do not use anyway) and to battle this
>>>>>> we can simply reduce its size by adding
>>>>>
>>>>> something that takes hardly any time with H_PUT_TCE_INDIRECT,  takes
>>>>> 13secs per device for H_PUT_TCE approach, during boot. This is with a
>>>>> 30GB guest. With larger guest, the time will further detoriate.
>>>>
>>>>
>>>> No it will not, I checked. The time is the same for 2GB and 32GB guests-
>>>> the delay is caused by clearing the small DMA window which is small by
>>>> the space mapped (1GB) but quite huge in TCEs as it uses 4K pages; and
>>>> for DDW window + emulated devices the IOMMU page size will be 2M/16M/1G
>>>> (depends on the system) so the number of TCEs is much smaller.
>>>
>>> I cant get your results.  What changes did you make to get it?
>>
>>
>> Get what? I passed "-m 2G" and "-m 32G", got the same time - 13s spent
>> in clearing the default window and the huge window took a fraction of a
>> second to create and map.
> 
> Is this if we disable FW_FEATURE_MULTITCE in the guest and force the use
> of H_PUT_TCE everywhere?


Yes. Well, for the DDW case FW_FEATURE_MULTITCE is ignored but even when
fixed (I have it in my local branch), this does not make a difference.


> 
> In theory couldn't we leave FW_FEATURE_MULTITCE in place so that
> iommu_table_clear() can still use H_STUFF_TCE (which I guess is basically
> instant),

PAPR/LoPAPR "conveniently" do not describe what hcall-multi-tce does
exactly. But I am pretty sure the idea is that either both H_STUFF_TCE
and H_PUT_TCE_INDIRECT are present or neither.


> and then force H_PUT_TCE for new mappings via something like:
> 
> diff --git a/arch/powerpc/platforms/pseries/iommu.c b/arch/powerpc/platforms/pseries/iommu.c
> index 6ba081dd61c9..85d092baf17d 100644
> --- a/arch/powerpc/platforms/pseries/iommu.c
> +++ b/arch/powerpc/platforms/pseries/iommu.c
> @@ -194,6 +194,7 @@ static int tce_buildmulti_pSeriesLP(struct iommu_table *tbl, long tcenum,
>         unsigned long flags;
>  
>         if ((npages == 1) || !firmware_has_feature(FW_FEATURE_MULTITCE)) {
> +       if ((npages == 1) || !firmware_has_feature(FW_FEATURE_MULTITCE) || is_secure_guest()) {


Nobody (including myself) seems to like the idea of having
is_secure_guest() all over the place.

And with KVM acceleration enabled, it is pretty fast anyway. Just now we
do not have H_PUT_TCE in KVM/UV for secure guests but we will have to
fix this for secure PCI passhtrough anyway.


>                 return tce_build_pSeriesLP(tbl, tcenum, npages, uaddr,
>                                            direction, attrs);
>         }
> 
> That seems like it would avoid the extra 13s.

Or move around iommu_table_clear() which imho is just the right thing to do.


> If we take the additional step of only mapping SWIOTLB range in
> enable_ddw() for is_secure_guest() that might further improve things
> (though the bigger motivation with that is the extra isolation it would
> grant us for stuff behind the IOMMU, since it apparently doesn't affect
> boot-time all that much)


Sure, we just need to confirm how many of these swiotlb banks we are
going to have (just one or many and at what location). Thanks,



> 
>>
>>
>>>>>>
>>>>>> -global
>>>>>> spapr-pci-host-bridge.dma_win_size=0x4000000
>>>>>
>>>>> This option, speeds it up tremendously.  But than should this option be
>>>>> enabled in qemu by default?  only for secure VMs? for both VMs?
>>>>
>>>>
>>>> As discussed in slack, by default we do not need to clear the entire TCE
>>>> table and we only have to map swiotlb buffer using the small window. It
>>>> is a guest kernel change only. Thanks,
>>>
>>> Can you tell me what code you are talking about here.  Where is the TCE
>>> table getting cleared? What code needs to be changed to not clear it?
>>
>>
>> pci_dma_bus_setup_pSeriesLP()
>>         iommu_init_table()
>>                 iommu_table_clear()
>>                         for () tbl->it_ops->get()
>>
>> We do not really need to clear it there, we only need it for VFIO with
>> IOMMU SPAPR TCE v1 which reuses these tables but there are
>> iommu_take_ownership/iommu_release_ownership to clear these tables. I'll
>> send a patch for this.
> 
> 
>>
>>
>>> Is the code in tce_buildmulti_pSeriesLP(), the one that does the clear
>>> aswell?
>>
>>
>> This one does not need to clear TCEs as this creates a window of known
>> size and maps it all.
>>
>> Well, actually, it only maps actual guest RAM, if there are gaps in RAM,
>> then TCEs for the gaps will have what hypervisor had there (which is
>> zeroes, qemu/kvm clears it anyway).
>>
>>
>>> But before I close, you have not told me clearly, what is the problem
>>> with;  'share the page, make the H_PUT_INDIRECT_TCE hcall, unshare the page'.
>>
>> Between share and unshare you have a (tiny) window of opportunity to
>> attack the guest. No, I do not know how exactly.
>>
>> For example, the hypervisor does a lot of PHB+PCI hotplug-unplug with
>> 64bit devices - each time this will create a huge window which will
>> share/unshare the same page.  No, I do not know how exactly how this can
>> be exploited either, we cannot rely of what you or myself know today. My
>> point is that we should not be sharing pages at all unless we really
>> really have to, and this does not seem to be the case.
>>
>> But since this seems to an acceptable compromise anyway,
>>
>> Reviewed-by: Alexey Kardashevskiy <aik@ozlabs.ru>
>>
>>
>>
>>
>>
>>> Remember this is the same page that is earmarked for doing
>>> H_PUT_INDIRECT_TCE, not by my patch, but its already earmarked by the
>>> existing code. So it not some random buffer that is picked. Second 
>>> this page is temporarily shared and unshared, it does not stay shared
>>> for life.  It does not slow the boot. it does not need any
>>> special command line options on the qemu.
>>>> Shared pages technology was put in place, exactly for the purpose of
>>> sharing data with the hypervisor.  We are using this technology exactly
>>> for that purpose.  And finally I agreed with your concern of having
>>> shared pages staying around.  Hence i addressed that concern, by
>>> unsharing the page.  At this point, I fail to understand your concern.
>>
>>
>>
>>
>> -- 
>> Alexey

-- 
Alexey
