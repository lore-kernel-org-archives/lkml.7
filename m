Return-Path: <SRS0=D3m8=SL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2C74C10F0E
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 13:26:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8DE7420880
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 13:26:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QM9UKVa+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727705AbfDIN0r (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Apr 2019 09:26:47 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:33231 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726372AbfDIN0r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Apr 2019 09:26:47 -0400
Received: by mail-lj1-f195.google.com with SMTP id f23so14496658ljc.0;
        Tue, 09 Apr 2019 06:26:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=CASyou2Sc1m+3jmTfHSR+07/UVxWLim07HVIVxer/F8=;
        b=QM9UKVa+z54hzoRQaRQutgkB4FNjCKrL8ToiG0FpPSWbfQijF3pORICjAGjxEb2cCS
         PfshY5ra6OlJmEGVOg9iiCYA8WawgErogRkPVvH3rQwEVtUsRl7eVMStKpIt7o8KrCXK
         5+Whw3iD4DhGa5yQ2BPelAhW8BR5xulGQMGj36ns5sdN1lP4OWw89gyuGfQke5ubQmy3
         3Kn7AhISpyzHpUsX6zsqhBBzLYp1BDOCdPKvA+njkGOAPoEBPX2b4lo2h568NJo8XrG5
         xfKuiiXinrqisOYQVTc9g/jzXJvNtF9Epa4ZvajIXd0AKZCiliLFhBGZP3XAVXKg4Baz
         8OAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=CASyou2Sc1m+3jmTfHSR+07/UVxWLim07HVIVxer/F8=;
        b=mMjTDLikCCMdECxXkH+MWxKlOv2R8QcJgZpWQY5Kj1Ny7wp+J1ZJuM/pCwz7Zt24Nw
         MqNFzXoo2TaTYuqle4QEcsZ/bGsqLSkXXdBJ5GY+EJpXd2qVI3JFfNQ88Ic3U+hDz1Hg
         lA/2A4DNphs9eNCA+cJgVnIsj/o6/WUg6TFVzYYCc35h61HG/cPU3E31ITffHo9b3FA5
         Qd/umMUm43dBywhlpSqjQI348IVHfueGsQPzLIcqy0kiP288qJ0SherJnBtBz1e79wJM
         r/PZ4EHNVLFQLDz66iPMABhlqqR4keV17yQIS46B6/e8apUDTocYbtB/tklU+801LOYh
         8v9Q==
X-Gm-Message-State: APjAAAU6XA/fGQyqV+TF3GFS2ZY6nMkWTd86BskkGq1kvvMaYiQSTsZ6
        VkKn/puX6s2lx/+4+dfUWBA=
X-Google-Smtp-Source: APXvYqy5Eo/vG8jxkKZDPJRcgp89sxGEhBJKfIbYIvyBM4tjgAdq2hAxBk5czCzxPJREKBBpYpGYbA==
X-Received: by 2002:a2e:9a02:: with SMTP id o2mr19358719lji.179.1554816404903;
        Tue, 09 Apr 2019 06:26:44 -0700 (PDT)
Received: from [10.17.182.20] (ll-22.209.223.85.sovam.net.ua. [85.223.209.22])
        by smtp.gmail.com with ESMTPSA id a16sm6555688lfl.86.2019.04.09.06.26.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 09 Apr 2019 06:26:44 -0700 (PDT)
Subject: Re: [Xen-devel][PATCH] xen/cameraif: add ABI for para-virtual camera
To:     Juergen Gross <jgross@suse.com>, xen-devel@lists.xenproject.org,
        linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        konrad.wilk@oracle.com, hverkuil@xs4all.nl,
        boris.ostrovsky@oracle.com
Cc:     Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>
References: <20190409091546.9606-1-andr2000@gmail.com>
 <9b9ba6b9-f045-80e2-fe8a-595728fb1ec0@suse.com>
 <5bb8c828-b0ae-86c3-dacf-88bf6032dd6f@gmail.com>
 <303b7d57-1785-62b3-fac0-a3e947e691c4@suse.com>
From:   Oleksandr Andrushchenko <andr2000@gmail.com>
Message-ID: <e9b3a843-1b1f-94c2-e123-09fb26d89753@gmail.com>
Date:   Tue, 9 Apr 2019 16:26:42 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <303b7d57-1785-62b3-fac0-a3e947e691c4@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/9/19 12:46 PM, Juergen Gross wrote:
> On 09/04/2019 11:33, Oleksandr Andrushchenko wrote:
>> On 4/9/19 12:28 PM, Juergen Gross wrote:
>>> On 09/04/2019 11:15, Oleksandr Andrushchenko wrote:
>>>> From: Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>
>>>>
>>>> This is the ABI for the two halves of a para-virtualized
>>>> camera driver which extends Xen's reach multimedia capabilities even
>>>> further enabling it for video conferencing, In-Vehicle Infotainment,
>>>> high definition maps etc.
>>>>
>>>> The initial goal is to support most needed functionality with the
>>>> final idea to make it possible to extend the protocol if need be:
>>>>
>>>> 1. Provide means for base virtual device configuration:
>>>>    - pixel formats
>>>>    - resolutions
>>>>    - frame rates
>>>> 2. Support basic camera controls:
>>>>    - contrast
>>>>    - brightness
>>>>    - hue
>>>>    - saturation
>>>> 3. Support streaming control
>>>>
>>>> Signed-off-by: Oleksandr Andrushchenko
>>>> <oleksandr_andrushchenko@epam.com>
>>>> Cc: Juergen Gross <jgross@suse.com>
>>>> Cc: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
>>>> Cc: Hans Verkuil <hverkuil@xs4all.nl>
>>> I'm in principle fine with this patch, but it should be sent as part of
>>> a series using that header. In case the related driver isn't accepted
>>> we'd end up with a stale header file.
>> Hm, I am doing this as I did for the rest of protocols before:
>> 1. Get the protocol in Xen
>> 2. Get the copy in Linux
>> 3. Upstream driver (use header)
> Sorry for not having done the review properly in the past. ;-)
>
>> Even if the driver is not accepted (hope this won't happen)
>> then this patch makes Xen and Linux properly aligned anyway.
>> Which is IMO good
> Having an unused header file is not good.
>
> Be assured I'm going to give you the needed Reviewed-by: tag for
> the patch adding the header in a series using it.
Ok, sounds good
>
>
> Juergen

