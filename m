Return-Path: <SRS0=6Pxm=X6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56BA7C4360C
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Oct 2019 03:08:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1498521D81
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Oct 2019 03:08:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ozlabs-ru.20150623.gappssmtp.com header.i=@ozlabs-ru.20150623.gappssmtp.com header.b="O2tOZ+rm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726747AbfJEDIw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Oct 2019 23:08:52 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:43035 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725887AbfJEDIv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Oct 2019 23:08:51 -0400
Received: by mail-pl1-f195.google.com with SMTP id f21so3991610plj.10
        for <linux-kernel@vger.kernel.org>; Fri, 04 Oct 2019 20:08:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ozlabs-ru.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:autocrypt:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=QQQk/yXItHMtaY1FgUSQ/D/iCGEeH0bka58Gcuq4gos=;
        b=O2tOZ+rm8DIuKzxtU9e2deiqPFtFDXZHgplQcOHLUk7bAbhlEZWYI+kVW1kMQ6e/Rq
         InwdJnQtrDqP1D3wwx+SNs5fNVmqzJ9f7fJAUaAo5mjrLTjvzFJ/zjfMJVXvkTALrvXu
         BXuDYXkNamkhYBbgCNsAFrva1yK8/5TV3r51WuUFAX5O0wDat7TorZ3WMMQxqn9Lptqy
         qoXWqg2/azzxRKbmOy7wp9iqrhRpErasNN3uOoBNlIMGkQROoEfeYmXsf6G8ztSNDcQm
         IaigLqrJLb+KVTnC7g38IzOM9Kkabsd0b1s0jTn0bbVtYw5q8VbEOfRd8XxNq4OV6Tgf
         LTdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=QQQk/yXItHMtaY1FgUSQ/D/iCGEeH0bka58Gcuq4gos=;
        b=kNhJwov3F1WG5ykWHEqJ4RXXKE42i4dqbAv3kHfSE8zReX8wUJIOt2YjAeCtJY80Fk
         DnGShuAfvXRVpiJn1VswyYpw8Lil4LySgimz0KRHYyUpfMPKoSfMqXiBcfo2DRVKTZpE
         ceBaX+l1w4Nc4YBq9JzxPh0eIBPDu0GvjkniAVXzUhNwB69nIiODwvsLCA40r4CqHkdd
         mmcmXdhJuVlz3NgWV8GnY42csZjewXcxzZdcYdzPXZzAkBMw+B/FHb2JjSak/1OXB5NP
         Oq0XGP/HyfmllOn7aHx+KxaEYzeL+SGI3DCPip8qCO3gAXaE7rwaISx76wU9VAtWl4vB
         1Jeg==
X-Gm-Message-State: APjAAAVCWdxlc5VIWMNgXkyqcdamIy4GLq6LROCeEdQdAvZRV7moZsrQ
        u+nInXiluT117Nop/B9Z50I/xC6s73nUaA==
X-Google-Smtp-Source: APXvYqysji/8R5ac4+ZJNUIwZmdCc45ZxA+V/W+lY00ShXJfumR38X3ff9Oe6JFlNlMHLh9N85gFiQ==
X-Received: by 2002:a17:902:7401:: with SMTP id g1mr18441655pll.20.1570244929059;
        Fri, 04 Oct 2019 20:08:49 -0700 (PDT)
Received: from [192.168.10.86] (203-206-37-215.dyn.iinet.net.au. [203.206.37.215])
        by smtp.gmail.com with ESMTPSA id e22sm6459088pgi.43.2019.10.04.20.08.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Oct 2019 20:08:48 -0700 (PDT)
Subject: Re: [PATCH v3 1/3] mm: kmemleak: Make the tool tolerant to struct
 scan_area allocation failures
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@kernel.org>,
        Matthew Wilcox <willy@infradead.org>, Qian Cai <cai@lca.pw>
References: <20190812160642.52134-1-catalin.marinas@arm.com>
 <20190812160642.52134-2-catalin.marinas@arm.com>
 <2ac37341-097e-17a2-fb6b-7912da9fa38e@ozlabs.ru>
 <20191003084135.GA21629@arrakis.emea.arm.com>
From:   Alexey Kardashevskiy <aik@ozlabs.ru>
Autocrypt: addr=aik@ozlabs.ru; keydata=
 mQINBE+rT0sBEADFEI2UtPRsLLvnRf+tI9nA8T91+jDK3NLkqV+2DKHkTGPP5qzDZpRSH6mD
 EePO1JqpVuIow/wGud9xaPA5uvuVgRS1q7RU8otD+7VLDFzPRiRE4Jfr2CW89Ox6BF+q5ZPV
 /pS4v4G9eOrw1v09lEKHB9WtiBVhhxKK1LnUjPEH3ifkOkgW7jFfoYgTdtB3XaXVgYnNPDFo
 PTBYsJy+wr89XfyHr2Ev7BB3Xaf7qICXdBF8MEVY8t/UFsesg4wFWOuzCfqxFmKEaPDZlTuR
 tfLAeVpslNfWCi5ybPlowLx6KJqOsI9R2a9o4qRXWGP7IwiMRAC3iiPyk9cknt8ee6EUIxI6
 t847eFaVKI/6WcxhszI0R6Cj+N4y+1rHfkGWYWupCiHwj9DjILW9iEAncVgQmkNPpUsZECLT
 WQzMuVSxjuXW4nJ6f4OFHqL2dU//qR+BM/eJ0TT3OnfLcPqfucGxubhT7n/CXUxEy+mvWwnm
 s9p4uqVpTfEuzQ0/bE6t7dZdPBua7eYox1AQnk8JQDwC3Rn9kZq2O7u5KuJP5MfludMmQevm
 pHYEMF4vZuIpWcOrrSctJfIIEyhDoDmR34bCXAZfNJ4p4H6TPqPh671uMQV82CfTxTrMhGFq
 8WYU2AH86FrVQfWoH09z1WqhlOm/KZhAV5FndwVjQJs1MRXD8QARAQABtCRBbGV4ZXkgS2Fy
 ZGFzaGV2c2tpeSA8YWlrQG96bGFicy5ydT6JAjgEEwECACIFAk+rT0sCGwMGCwkIBwMCBhUI
 AgkKCwQWAgMBAh4BAheAAAoJEIYTPdgrwSC5fAIP/0wf/oSYaCq9PhO0UP9zLSEz66SSZUf7
 AM9O1rau1lJpT8RoNa0hXFXIVbqPPKPZgorQV8SVmYRLr0oSmPnTiZC82x2dJGOR8x4E01gK
 TanY53J/Z6+CpYykqcIpOlGsytUTBA+AFOpdaFxnJ9a8p2wA586fhCZHVpV7W6EtUPH1SFTQ
 q5xvBmr3KkWGjz1FSLH4FeB70zP6uyuf/B2KPmdlPkyuoafl2UrU8LBADi/efc53PZUAREih
 sm3ch4AxaL4QIWOmlE93S+9nHZSRo9jgGXB1LzAiMRII3/2Leg7O4hBHZ9Nki8/fbDo5///+
 kD4L7UNbSUM/ACWHhd4m1zkzTbyRzvL8NAVQ3rckLOmju7Eu9whiPueGMi5sihy9VQKHmEOx
 OMEhxLRQbzj4ypRLS9a+oxk1BMMu9cd/TccNy0uwx2UUjDQw/cXw2rRWTRCxoKmUsQ+eNWEd
 iYLW6TCfl9CfHlT6A7Zmeqx2DCeFafqEd69DqR9A8W5rx6LQcl0iOlkNqJxxbbW3ddDsLU/Y
 r4cY20++WwOhSNghhtrroP+gouTOIrNE/tvG16jHs8nrYBZuc02nfX1/gd8eguNfVX/ZTHiR
 gHBWe40xBKwBEK2UeqSpeVTohYWGBkcd64naGtK9qHdo1zY1P55lHEc5Uhlk743PgAnOi27Q
 ns5zuQINBE+rT0sBEACnV6GBSm+25ACT+XAE0t6HHAwDy+UKfPNaQBNTTt31GIk5aXb2Kl/p
 AgwZhQFEjZwDbl9D/f2GtmUHWKcCmWsYd5M/6Ljnbp0Ti5/xi6FyfqnO+G/wD2VhGcKBId1X
 Em/B5y1kZVbzcGVjgD3HiRTqE63UPld45bgK2XVbi2+x8lFvzuFq56E3ZsJZ+WrXpArQXib2
 hzNFwQleq/KLBDOqTT7H+NpjPFR09Qzfa7wIU6pMNF2uFg5ihb+KatxgRDHg70+BzQfa6PPA
 o1xioKXW1eHeRGMmULM0Eweuvpc7/STD3K7EJ5bBq8svoXKuRxoWRkAp9Ll65KTUXgfS+c0x
 gkzJAn8aTG0z/oEJCKPJ08CtYQ5j7AgWJBIqG+PpYrEkhjzSn+DZ5Yl8r+JnZ2cJlYsUHAB9
 jwBnWmLCR3gfop65q84zLXRQKWkASRhBp4JK3IS2Zz7Nd/Sqsowwh8x+3/IUxVEIMaVoUaxk
 Wt8kx40h3VrnLTFRQwQChm/TBtXqVFIuv7/Mhvvcq11xnzKjm2FCnTvCh6T2wJw3de6kYjCO
 7wsaQ2y3i1Gkad45S0hzag/AuhQJbieowKecuI7WSeV8AOFVHmgfhKti8t4Ff758Z0tw5Fpc
 BFDngh6Lty9yR/fKrbkkp6ux1gJ2QncwK1v5kFks82Cgj+DSXK6GUQARAQABiQIfBBgBAgAJ
 BQJPq09LAhsMAAoJEIYTPdgrwSC5NYEP/2DmcEa7K9A+BT2+G5GXaaiFa098DeDrnjmRvumJ
 BhA1UdZRdfqICBADmKHlJjj2xYo387sZpS6ABbhrFxM6s37g/pGPvFUFn49C47SqkoGcbeDz
 Ha7JHyYUC+Tz1dpB8EQDh5xHMXj7t59mRDgsZ2uVBKtXj2ZkbizSHlyoeCfs1gZKQgQE8Ffc
 F8eWKoqAQtn3j4nE3RXbxzTJJfExjFB53vy2wV48fUBdyoXKwE85fiPglQ8bU++0XdOr9oyy
 j1llZlB9t3tKVv401JAdX8EN0++ETiOovQdzE1m+6ioDCtKEx84ObZJM0yGSEGEanrWjiwsa
 nzeK0pJQM9EwoEYi8TBGhHC9ksaAAQipSH7F2OHSYIlYtd91QoiemgclZcSgrxKSJhyFhmLr
 QEiEILTKn/pqJfhHU/7R7UtlDAmFMUp7ByywB4JLcyD10lTmrEJ0iyRRTVfDrfVP82aMBXgF
 tKQaCxcmLCaEtrSrYGzd1sSPwJne9ssfq0SE/LM1J7VdCjm6OWV33SwKrfd6rOtvOzgadrG6
 3bgUVBw+bsXhWDd8tvuCXmdY4bnUblxF2B6GOwSY43v6suugBttIyW5Bl2tXSTwP+zQisOJo
 +dpVG2pRr39h+buHB3NY83NEPXm1kUOhduJUA17XUY6QQCAaN4sdwPqHq938S3EmtVhsuQIN
 BFq54uIBEACtPWrRdrvqfwQF+KMieDAMGdWKGSYSfoEGGJ+iNR8v255IyCMkty+yaHafvzpl
 PFtBQ/D7Fjv+PoHdFq1BnNTk8u2ngfbre9wd9MvTDsyP/TmpF0wyyTXhhtYvE267Av4X/BQT
 lT9IXKyAf1fP4BGYdTNgQZmAjrRsVUW0j6gFDrN0rq2J9emkGIPvt9rQt6xGzrd6aXonbg5V
 j6Uac1F42ESOZkIh5cN6cgnGdqAQb8CgLK92Yc8eiCVCH3cGowtzQ2m6U32qf30cBWmzfSH0
 HeYmTP9+5L8qSTA9s3z0228vlaY0cFGcXjdodBeVbhqQYseMF9FXiEyRs28uHAJEyvVZwI49
 CnAgVV/n1eZa5qOBpBL+ZSURm8Ii0vgfvGSijPGbvc32UAeAmBWISm7QOmc6sWa1tobCiVmY
 SNzj5MCNk8z4cddoKIc7Wt197+X/X5JPUF5nQRvg3SEHvfjkS4uEst9GwQBpsbQYH9MYWq2P
 PdxZ+xQE6v7cNB/pGGyXqKjYCm6v70JOzJFmheuUq0Ljnfhfs15DmZaLCGSMC0Amr+rtefpA
 y9FO5KaARgdhVjP2svc1F9KmTUGinSfuFm3quadGcQbJw+lJNYIfM7PMS9fftq6vCUBoGu3L
 j4xlgA/uQl/LPneu9mcvit8JqcWGS3fO+YeagUOon1TRqQARAQABiQRsBBgBCAAgFiEEZSrP
 ibrORRTHQ99dhhM92CvBILkFAlq54uICGwICQAkQhhM92CvBILnBdCAEGQEIAB0WIQQIhvWx
 rCU+BGX+nH3N7sq0YorTbQUCWrni4gAKCRDN7sq0YorTbVVSD/9V1xkVFyUCZfWlRuryBRZm
 S4GVaNtiV2nfUfcThQBfF0sSW/aFkLP6y+35wlOGJE65Riw1C2Ca9WQYk0xKvcZrmuYkK3DZ
 0M9/Ikkj5/2v0vxz5Z5w/9+IaCrnk7pTnHZuZqOh23NeVZGBls/IDIvvLEjpD5UYicH0wxv+
 X6cl1RoP2Kiyvenf0cS73O22qSEw0Qb9SId8wh0+ClWet2E7hkjWFkQfgJ3hujR/JtwDT/8h
 3oCZFR0KuMPHRDsCepaqb/k7VSGTLBjVDOmr6/C9FHSjq0WrVB9LGOkdnr/xcISDZcMIpbRm
 EkIQ91LkT/HYIImL33ynPB0SmA+1TyMgOMZ4bakFCEn1vxB8Ir8qx5O0lHMOiWMJAp/PAZB2
 r4XSSHNlXUaWUg1w3SG2CQKMFX7vzA31ZeEiWO8tj/c2ZjQmYjTLlfDK04WpOy1vTeP45LG2
 wwtMA1pKvQ9UdbYbovz92oyZXHq81+k5Fj/YA1y2PI4MdHO4QobzgREoPGDkn6QlbJUBf4To
 pEbIGgW5LRPLuFlOPWHmIS/sdXDrllPc29aX2P7zdD/ivHABslHmt7vN3QY+hG0xgsCO1JG5
 pLORF2N5XpM95zxkZqvYfC5tS/qhKyMcn1kC0fcRySVVeR3tUkU8/caCqxOqeMe2B6yTiU1P
 aNDq25qYFLeYxg67D/4w/P6BvNxNxk8hx6oQ10TOlnmeWp1q0cuutccblU3ryRFLDJSngTEu
 ZgnOt5dUFuOZxmMkqXGPHP1iOb+YDznHmC0FYZFG2KAc9pO0WuO7uT70lL6larTQrEneTDxQ
 CMQLP3qAJ/2aBH6SzHIQ7sfbsxy/63jAiHiT3cOaxAKsWkoV2HQpnmPOJ9u02TPjYmdpeIfa
 X2tXyeBixa3i/6dWJ4nIp3vGQicQkut1YBwR7dJq67/FCV3Mlj94jI0myHT5PIrCS2S8LtWX
 ikTJSxWUKmh7OP5mrqhwNe0ezgGiWxxvyNwThOHc5JvpzJLd32VDFilbxgu4Hhnf6LcgZJ2c
 Zd44XWqUu7FzVOYaSgIvTP0hNrBYm/E6M7yrLbs3JY74fGzPWGRbBUHTZXQEqQnZglXaVB5V
 ZhSFtHopZnBSCUSNDbB+QGy4B/E++Bb02IBTGl/JxmOwG+kZUnymsPvTtnNIeTLHxN/H/ae0
 c7E5M+/NpslPCmYnDjs5qg0/3ihh6XuOGggZQOqrYPC3PnsNs3NxirwOkVPQgO6mXxpuifvJ
 DG9EMkK8IBXnLulqVk54kf7fE0jT/d8RTtJIA92GzsgdK2rpT1MBKKVffjRFGwN7nQVOzi4T
 XrB5p+6ML7Bd84xOEGsj/vdaXmz1esuH7BOZAGEZfLRCHJ0GVCSssg==
Message-ID: <ba47fb68-f44c-04c9-7ea8-2705e799937b@ozlabs.ru>
Date:   Sat, 5 Oct 2019 13:08:43 +1000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191003084135.GA21629@arrakis.emea.arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 03/10/2019 18:41, Catalin Marinas wrote:
> On Thu, Oct 03, 2019 at 04:13:07PM +1000, Alexey Kardashevskiy wrote:
>> On 13/08/2019 02:06, Catalin Marinas wrote:
>>> Object scan areas are an optimisation aimed to decrease the false
>>> positives and slightly improve the scanning time of large objects known
>>> to only have a few specific pointers. If a struct scan_area fails to
>>> allocate, kmemleak can still function normally by scanning the full
>>> object.
>>>
>>> Introduce an OBJECT_FULL_SCAN flag and mark objects as such when
>>> scan_area allocation fails.
>>
>> I came across this one while bisecting sudden drop in throughput of a
>> 100Gbit Mellanox CX4 ethernet card in a PPC POWER9 system, the speed
>> dropped from 100Gbit to about 40Gbit. Bisect pointed at dba82d943177,
>> this are the relevant config options:
>>
>> [fstn1-p1 kernel]$ grep KMEMLEAK ~/pbuild/kernel-le-4g/.config
>> CONFIG_HAVE_DEBUG_KMEMLEAK=y
>> CONFIG_DEBUG_KMEMLEAK=y
>> CONFIG_DEBUG_KMEMLEAK_EARLY_LOG_SIZE=16000
>> # CONFIG_DEBUG_KMEMLEAK_TEST is not set
>> # CONFIG_DEBUG_KMEMLEAK_DEFAULT_OFF is not set
>> CONFIG_DEBUG_KMEMLEAK_AUTO_SCAN=y
> 
> The throughput drop is probably caused caused by kmemleak slowing down
> all memory allocations (including skb). So that's expected. You may get
> similar drop with other debug options like lock proving, kasan.

I was not precise. I meant that before dba82d943177 kmemleak would work but would not slow network down (at least
100Gbit) and now it does which is downgrade so I was wondering if kmemleak just got so much better to justify this
change or there is a bug somewhere, so which one is it? Or "LOG_SIZE=400" never really worked? See my findings below though.

If it was always slow, it is expected indeed.

> 
>> Setting CONFIG_DEBUG_KMEMLEAK_MEM_POOL_SIZE=400 or even 4000 (this is
>> what KMEMLEAK_EARLY_LOG_SIZE is now in the master) produces soft
>> lockups on the recent upstream (sha1 a3c0e7b1fe1f):
>>
>> [c000001fde64fb60] [c000000000c24ed4] _raw_write_unlock_irqrestore+0x54/0x70
>> [c000001fde64fb90] [c0000000004117e4] find_and_remove_object+0xa4/0xd0
>> [c000001fde64fbe0] [c000000000411c74] delete_object_full+0x24/0x50
>> [c000001fde64fc00] [c000000000411d28] __kmemleak_do_cleanup+0x88/0xd0
>> [c000001fde64fc40] [c00000000012a1a4] process_one_work+0x374/0x6a0
>> [c000001fde64fd20] [c00000000012a548] worker_thread+0x78/0x5a0
>> [c000001fde64fdb0] [c000000000135508] kthread+0x198/0x1a0
>> [c000001fde64fe20] [c00000000000b980] ret_from_kernel_thread+0x5c/0x7c
> 
> That's the kmemleak disabling path. I don't have the full log but I
> suspect by setting a small pool size, kmemleak failed to allocate memory
> and went into disabling itself. The clean-up above tries to remove the
> allocated metadata. It seems that it takes significant time on your
> platform. Not sure how to avoid the soft lock-up but I wouldn't bother
> too much about it, it's only triggered by a previous error condition
> disabling kmemleak.
> 
>> KMEMLEAK_EARLY_LOG_SIZE=8000 works but slow.
>>
>> Interestingly KMEMLEAK_EARLY_LOG_SIZE=400 on dba82d943177 still worked
>> and I saw my 100Gbit. Disabling KMEMLEAK also fixes the speed
>> (apparently).
> 
> A small memory pool for kmemleak just disables it shortly after boot, so
> it's no longer in the way and you get your throughput back.
> 
>> Is that something expected? Thanks,
> 
> Yes for the throughput. Not sure about the soft lock-up. Do you have the
> full log around the lock-up?

I was going to post one but then I received "kmemleak: Do not corrupt the object_list during clean-up" which fixed
lockups and took throughput back to normal, I'll reply there too. Thanks,


-- 
Alexey
