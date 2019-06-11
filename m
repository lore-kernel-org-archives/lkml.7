Return-Path: <SRS0=TvG7=UK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58148C43218
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 14:00:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 27D0C206BB
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 14:00:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="bhgTz0iZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389344AbfFKOAI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Jun 2019 10:00:08 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:45227 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387447AbfFKOAI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jun 2019 10:00:08 -0400
Received: by mail-qt1-f194.google.com with SMTP id j19so14575716qtr.12
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jun 2019 07:00:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=iH+zv2NyAQjL/cetbGgHsTzopn+UouK4esOdVcCu/XI=;
        b=bhgTz0iZHBzC141cQuSxSqaQ6tDQrIVqrdGGE0dsBQadX/i+4Srh9EvKSjvHWfQ96D
         y2/cwNUfbWYskuiT226QmbdLGzCBH8hWz9FWoA4qjTsZTIh79U8wHlWpwNLnNQ+8JvH4
         zF4Uzn/c5bbpMhM/SmrCJSY0O+LNAhxKJJW/VLPUMF9Lqhzmc+SGBK3bs8/gKSezBo7D
         LEgR6ItfMPm9Bhlj+vAqpHPpKifwv5kI1a1Jb8xOOt/cLRvUH6CbcGDZuCZwcmca9f5X
         +Fi4AbP1s9Hf4l4QzWm9wqogQWYEIKC8tAw5SxUcMoFLWmIgXfp0wg2aRDcoXfX6HsSH
         drcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=iH+zv2NyAQjL/cetbGgHsTzopn+UouK4esOdVcCu/XI=;
        b=VKZxg88JixTtbhS1dT6aYKtfAGilrHOp1CkVNh5nVnw5t0ROyDHi14XcYbxRNnD8cf
         phnc4mQlBWe5nEXXNYUVoWqgtseClFAGGYtnx7qjYZ8sP3/grH2cpxSWe2+ZiJUXpdkr
         6+B6dVd7vqZSThvPR3q0DXfP5sOPCnhY7WGRg5c7J3K8U5324oGvQWlsDfjz93nbdQW+
         nYLzgczmGBcuUm6n54flLsEW/obHoGKzx3G4azHHeVQu/T1sOHiVUxsJHxSnVYfFE+bL
         qxt72khFLaaKLG/L9sUpTzk77iQXhCdQBVQKax1XmMMSKt4t/CxqJ8D50tGsbekF1cdS
         AJSQ==
X-Gm-Message-State: APjAAAVnswus40ZfHkwx9H86oG6R7Yn0kT5LTde4/UgqzgdqaQie8I5t
        LEn7KzWj34ltjHsjAhp3cQeztw==
X-Google-Smtp-Source: APXvYqwvcMDBx+2FFUxbbsHqiUbAKE+XOonBFHNUuVkdEbObgeEeNT+erbNtoXX9y+IO9kDx1s/nVQ==
X-Received: by 2002:a0c:b084:: with SMTP id o4mr35367656qvc.227.1560261607009;
        Tue, 11 Jun 2019 07:00:07 -0700 (PDT)
Received: from [192.168.1.153] (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id g53sm3000938qtk.65.2019.06.11.07.00.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 11 Jun 2019 07:00:06 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: Re: "iommu/vt-d: Delegate DMA domain to generic iommu" series breaks
 megaraid_sas
From:   Qian Cai <cai@lca.pw>
In-Reply-To: <2ff8404d-7103-a96d-2749-ac707ce74563@linux.intel.com>
Date:   Tue, 11 Jun 2019 10:00:02 -0400
Cc:     James Sewart <jamessewart@arista.com>,
        Joerg Roedel <jroedel@suse.de>,
        iommu@lists.linux-foundation.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Kashyap Desai <kashyap.desai@broadcom.com>,
        Sumit Saxena <sumit.saxena@broadcom.com>,
        Shivasharan S <shivasharan.srikanteshwara@broadcom.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <AB191BD9-239D-4962-AED3-52AABED5C7C0@lca.pw>
References: <1559941717.6132.63.camel@lca.pw>
 <1e4f0642-e4e1-7602-3f50-37edc84ced50@linux.intel.com>
 <1560174264.6132.65.camel@lca.pw> <1560178459.6132.66.camel@lca.pw>
 <2ff8404d-7103-a96d-2749-ac707ce74563@linux.intel.com>
To:     Lu Baolu <baolu.lu@linux.intel.com>
X-Mailer: Apple Mail (2.3445.104.11)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Jun 10, 2019, at 9:41 PM, Lu Baolu <baolu.lu@linux.intel.com> =
wrote:
>=20
> Ah, good catch!
>=20
> The device failed to be attached by a DMA domain. Can you please try =
the
> attached fix patch?

It works fine.

>=20
> [  101.885468] pci 0000:06:00.0: DMAR: Device is ineligible for IOMMU
> domain attach due to platform RMRR requirement.  Contact your platform
> vendor.
> [  101.900801] pci 0000:06:00.0: Failed to add to iommu group 23: -1
>=20
> Best regards,
> Baolu
>=20
> On 6/10/19 10:54 PM, Qian Cai wrote:
>> On Mon, 2019-06-10 at 09:44 -0400, Qian Cai wrote:
>>> On Sun, 2019-06-09 at 10:43 +0800, Lu Baolu wrote:
>>>> Hi Qian,
>>>>=20
>>>> I just posted some fix patches. I cc'ed them in your email inbox as
>>>> well. Can you please check whether they happen to fix your issue?
>>>> If not, do you mind posting more debug messages?
>>>=20
>>> Unfortunately, it does not work. Here is the dmesg.
>>>=20
>>> =
https://raw.githubusercontent.com/cailca/tmp/master/dmesg?token=3DAMC35QKP=
IZBYUM
>>> FUQKLW4ZC47ZPIK
>> This one should be good to view.
>> https://cailca.github.io/files/dmesg.txt
> <0001-iommu-vt-d-Allow-DMA-domain-attaching-to-rmrr-locked.patch>

