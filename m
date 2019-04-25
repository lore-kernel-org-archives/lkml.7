Return-Path: <SRS0=Q+aa=S3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50018C282E1
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 09:07:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 26D81217FA
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 09:07:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728100AbfDYJHO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 05:07:14 -0400
Received: from mx2.suse.de ([195.135.220.15]:53030 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726150AbfDYJHN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 05:07:13 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 93AFFACA5;
        Thu, 25 Apr 2019 09:07:11 +0000 (UTC)
Subject: Re: [Xen-devel] [PATCH 3/3] xen/swiotlb: remember having called
 xen_create_contiguous_region()
To:     Jan Beulich <JBeulich@suse.com>
Cc:     Stefano Stabellini <sstabellini@kernel.org>,
        iommu@lists.linux-foundation.org,
        xen-devel <xen-devel@lists.xenproject.org>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        lkml <linux-kernel@vger.kernel.org>
References: =?UTF-8?B?PDIwMTkwNDIzMTA1NDU3LjE3NTAy77+9Me+/vWpncm9zc0BzdXNl?=
 =?UTF-8?B?LmNvbT4gPDIwMTkwNDIzMTA1NDU3LjE3NTAy77+9NO+/vWpncm9zc0BzdXNlLmNv?=
 =?UTF-8?Q?m=3e_=3calpine=2eDEB=2e2=2e10=2e1904230955190=2e24598=40sstabelli?=
 =?UTF-8?Q?ni=ef=bf=bdThinkPad=ef=bf=bdX260=3e_=3ce744c7eb-1685-13b6-7ae9-e9?=
 =?UTF-8?Q?52f8f53ab0=40suse=2ecom=3e_=3c5CC177740200007800228EB2=40suse=2ec?=
 =?UTF-8?B?b20+?=
From:   Juergen Gross <jgross@suse.com>
Openpgp: preference=signencrypt
Autocrypt: addr=jgross@suse.com; prefer-encrypt=mutual; keydata=
 mQENBFOMcBYBCACgGjqjoGvbEouQZw/ToiBg9W98AlM2QHV+iNHsEs7kxWhKMjrioyspZKOB
 ycWxw3ie3j9uvg9EOB3aN4xiTv4qbnGiTr3oJhkB1gsb6ToJQZ8uxGq2kaV2KL9650I1SJve
 dYm8Of8Zd621lSmoKOwlNClALZNew72NjJLEzTalU1OdT7/i1TXkH09XSSI8mEQ/ouNcMvIJ
 NwQpd369y9bfIhWUiVXEK7MlRgUG6MvIj6Y3Am/BBLUVbDa4+gmzDC9ezlZkTZG2t14zWPvx
 XP3FAp2pkW0xqG7/377qptDmrk42GlSKN4z76ELnLxussxc7I2hx18NUcbP8+uty4bMxABEB
 AAG0H0p1ZXJnZW4gR3Jvc3MgPGpncm9zc0BzdXNlLmNvbT6JATkEEwECACMFAlOMcK8CGwMH
 CwkIBwMCAQYVCAIJCgsEFgIDAQIeAQIXgAAKCRCw3p3WKL8TL8eZB/9G0juS/kDY9LhEXseh
 mE9U+iA1VsLhgDqVbsOtZ/S14LRFHczNd/Lqkn7souCSoyWsBs3/wO+OjPvxf7m+Ef+sMtr0
 G5lCWEWa9wa0IXx5HRPW/ScL+e4AVUbL7rurYMfwCzco+7TfjhMEOkC+va5gzi1KrErgNRHH
 kg3PhlnRY0Udyqx++UYkAsN4TQuEhNN32MvN0Np3WlBJOgKcuXpIElmMM5f1BBzJSKBkW0Jc
 Wy3h2Wy912vHKpPV/Xv7ZwVJ27v7KcuZcErtptDevAljxJtE7aJG6WiBzm+v9EswyWxwMCIO
 RoVBYuiocc51872tRGywc03xaQydB+9R7BHPuQENBFOMcBYBCADLMfoA44MwGOB9YT1V4KCy
 vAfd7E0BTfaAurbG+Olacciz3yd09QOmejFZC6AnoykydyvTFLAWYcSCdISMr88COmmCbJzn
 sHAogjexXiif6ANUUlHpjxlHCCcELmZUzomNDnEOTxZFeWMTFF9Rf2k2F0Tl4E5kmsNGgtSa
 aMO0rNZoOEiD/7UfPP3dfh8JCQ1VtUUsQtT1sxos8Eb/HmriJhnaTZ7Hp3jtgTVkV0ybpgFg
 w6WMaRkrBh17mV0z2ajjmabB7SJxcouSkR0hcpNl4oM74d2/VqoW4BxxxOD1FcNCObCELfIS
 auZx+XT6s+CE7Qi/c44ibBMR7hyjdzWbABEBAAGJAR8EGAECAAkFAlOMcBYCGwwACgkQsN6d
 1ii/Ey9D+Af/WFr3q+bg/8v5tCknCtn92d5lyYTBNt7xgWzDZX8G6/pngzKyWfedArllp0Pn
 fgIXtMNV+3t8Li1Tg843EXkP7+2+CQ98MB8XvvPLYAfW8nNDV85TyVgWlldNcgdv7nn1Sq8g
 HwB2BHdIAkYce3hEoDQXt/mKlgEGsLpzJcnLKimtPXQQy9TxUaLBe9PInPd+Ohix0XOlY+Uk
 QFEx50Ki3rSDl2Zt2tnkNYKUCvTJq7jvOlaPd6d/W0tZqpyy7KVay+K4aMobDsodB3dvEAs6
 ScCnh03dDAFgIq5nsB11j3KPKdVoPlfucX2c7kGNH+LUMbzqV6beIENfNexkOfxHf4kBrQQY
 AQgAIBYhBIUSZ3Lo9gSUpdCX97DendYovxMvBQJa3fDQAhsCAIEJELDendYovxMvdiAEGRYI
 AB0WIQRTLbB6QfY48x44uB6AXGG7T9hjvgUCWt3w0AAKCRCAXGG7T9hjvk2LAP99B/9FenK/
 1lfifxQmsoOrjbZtzCS6OKxPqOLHaY47BgEAqKKn36YAPpbk09d2GTVetoQJwiylx/Z9/mQI
 CUbQMg1pNQf9EjA1bNcMbnzJCgt0P9Q9wWCLwZa01SnQWFz8Z4HEaKldie+5bHBL5CzVBrLv
 81tqX+/j95llpazzCXZW2sdNL3r8gXqrajSox7LR2rYDGdltAhQuISd2BHrbkQVEWD4hs7iV
 1KQHe2uwXbKlguKPhk5ubZxqwsg/uIHw0qZDk+d0vxjTtO2JD5Jv/CeDgaBX4Emgp0NYs8IC
 UIyKXBtnzwiNv4cX9qKlz2Gyq9b+GdcLYZqMlIBjdCz0yJvgeb3WPNsCOanvbjelDhskx9gd
 6YUUFFqgsLtrKpCNyy203a58g2WosU9k9H+LcheS37Ph2vMVTISMszW9W8gyORSgmw==
Message-ID: <a1203397-9704-192a-c157-442dbeee62c5@suse.com>
Date:   Thu, 25 Apr 2019 11:07:11 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25/04/2019 11:01, Jan Beulich wrote:
>>>> On 23.04.19 at 20:36, <jgross@suse.com> wrote:
>> On 23/04/2019 19:05, Stefano Stabellini wrote:
>>> On Tue, 23 Apr 2019, Juergen Gross wrote:
>>>> Instead of always calling xen_destroy_contiguous_region() in case the
>>>> memory is DMA-able for the used device, do so only in case it has been
>>>> made DMA-able via xen_create_contiguous_region() before.
>>>>
>>>> This will avoid a lot of xen_destroy_contiguous_region() calls for
>>>> 64-bit capable devices.
>>>>
>>>> As the memory in question is owned by swiotlb-xen the PG_owner_priv_1
>>>> flag of the first allocated page can be used for remembering.
>>>
>>> Although the patch looks OK, this sentence puzzles me. Why do you say
>>> that the memory in question is owned by swiotlb-xen? Because it was
>>> returned by xen_alloc_coherent_pages? Both the x86 and the Arm
>>> implementation return fresh new memory, hence, it should be safe to set
>>> the PageOwnerPriv1 flag?
>>>
>>> My concern with this approach is with the semantics of PG_owner_priv_1.
>>> Is a page marked with PG_owner_priv_1 only supposed to be used by the
>>> owner?
>>
>> The owner of the page is free to use the flag.
>>
>> Like Grant pages are marked by the grant driver using this flag. And
>> Xen page tables are using it in PV-guests for indicating a "Pinned"
>> page table.
> 
> Considering the background of the series, isn't such multi-purpose use
> of the flag a possible problem? You're already suspecting a wrong call
> into here. The function finding the flag set (but for another reason)
> might add to the confusion. But I realize there are only so many page
> flags available.

Right.

> Perhaps the freeing function should, first thing, check the handed
> space actually matches the criteria (within dma_mask and contiguous)?

Yes, I think this is a good idea.


Juergen
