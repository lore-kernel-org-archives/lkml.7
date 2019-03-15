Return-Path: <SRS0=8sqo=RS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40847C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 20:07:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 17B3F218D3
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 20:07:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726967AbfCOUHg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Mar 2019 16:07:36 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:40976 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726691AbfCOUHe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Mar 2019 16:07:34 -0400
Received: by mail-qk1-f195.google.com with SMTP id o129so6278042qke.8
        for <linux-kernel@vger.kernel.org>; Fri, 15 Mar 2019 13:07:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=aS+n8Rk+4bF8hSk8QDwRcNzlyMpahiBZ9HYF+1hPykM=;
        b=etqJSVGiq/Vp49yUS8Rf+gaUQ1jxYccIMWQ+Nqxxi+P34GwWt/wcfi22DqBajnh9iX
         mBMx1NTfgw3U58PWV46dOcYpUonbFFPYw/4xlQBjkB83t2hvuCC8O+ZYxrQ714YMJjA0
         oUapxM2YA6KF//FWOa70Xbh1kWAoEkNtfYA+6Hc7cOi23BLaJDuIqccw8GlqN1iDHt5C
         UnV3z0/49KDqsOfLhnWIYf5OU2AKOPFRbFlBbntrQuks4cySmeor1UffOgO6+Xuamp6l
         WTpQyLlmDiec+r1cx4UPH3Ztihvo+IvUa9hM/UiQ6fBHQdDzgeSUYIwrJqv9tXCjumYY
         q4cg==
X-Gm-Message-State: APjAAAVd1dDKjaKi4lL8rBpBQc0dzubMvgqnPODr1LZu9TC2czMe3Zl8
        LcrSpZoTeWrockb6xfOnLw6lyg==
X-Google-Smtp-Source: APXvYqw/xCWshOzSchvP48LTL8RLsf9UTrhcxSqhYpteqVCTomiMLlopg1xmPmZk7o0Gy+M0HHzu6w==
X-Received: by 2002:a37:a650:: with SMTP id p77mr4305800qke.256.1552680453360;
        Fri, 15 Mar 2019 13:07:33 -0700 (PDT)
Received: from ?IPv6:2601:602:9800:dae6::362? ([2601:602:9800:dae6::362])
        by smtp.gmail.com with ESMTPSA id x15sm1889862qts.21.2019.03.15.13.07.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 15 Mar 2019 13:07:32 -0700 (PDT)
Subject: Re: [RFC][PATCH 5/5 v2] kselftests: Add dma-heap test
To:     John Stultz <john.stultz@linaro.org>,
        Benjamin Gaignard <benjamin.gaignard@linaro.org>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Liam Mark <lmark@codeaurora.org>,
        Brian Starkey <Brian.Starkey@arm.com>,
        "Andrew F . Davis" <afd@ti.com>, Chenbo Feng <fengc@google.com>,
        Alistair Strachan <astrachan@google.com>,
        ML dri-devel <dri-devel@lists.freedesktop.org>
References: <1551819273-640-1-git-send-email-john.stultz@linaro.org>
 <1551819273-640-6-git-send-email-john.stultz@linaro.org>
 <CA+M3ks6AUmmYbXscjTRo+Vr-6cV8okafsDn2Tg3tskvzrV_dbA@mail.gmail.com>
 <CALAqxLWxpExDpiKbNGQ6Oz5h=FUPNLvehm34JdrntLQjFed41w@mail.gmail.com>
From:   Laura Abbott <labbott@redhat.com>
Message-ID: <232410de-f20c-cde8-fdbb-48ca8ec1223b@redhat.com>
Date:   Fri, 15 Mar 2019 13:07:29 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <CALAqxLWxpExDpiKbNGQ6Oz5h=FUPNLvehm34JdrntLQjFed41w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/6/19 9:01 AM, John Stultz wrote:
> On Wed, Mar 6, 2019 at 8:14 AM Benjamin Gaignard
> <benjamin.gaignard@linaro.org> wrote:
>> Le mar. 5 mars 2019 à 21:54, John Stultz <john.stultz@linaro.org> a écrit :
>>> +
>>> +       printf("Allocating 1 MEG\n");
>>> +       ret = dmabuf_heap_alloc(heap_fd, ONE_MEG, 0, &dmabuf_fd);
>>> +       if (ret)
>>> +               goto out;
>>> +
>>> +       /* DO SOMETHING WITH THE DMABUF HERE? */
>>
>> You can do a call to mmap and write a pattern in the buffer.
> 
> Yea. I can also do some invalid allocations to make sure things fail properly.
> 
> But I was talking a bit w/ Sumit about the lack of any general dmabuf
> tests, and am curious if we need to have a importer device driver that
> can validate its a real dmabuf and exercise more of the dmabuf ops.
> 
> thanks
> -john
> 

There's the vgem driver in drm. I did some work to clean that
up so it could take an import af33a9190d02 ("drm/vgem: Enable dmabuf import
interfaces") . I mostly used it for private tests and never ended
up upstreaming any of the tests.

Thanks,
Laura
