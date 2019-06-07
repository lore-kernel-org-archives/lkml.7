Return-Path: <SRS0=2dYc=UG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D307C28CC3
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 06:50:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 008862089E
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 06:50:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1559890208;
	bh=LxuYK6M9s/sQ5nBReT1XjiE8X0ZCHsRV11hvfjmLXZc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:List-ID:From;
	b=qRlDTi8RzWEli0GyenPoF+sh131Q3+9A1xD2QKfGWTI5GVg0WSOos4vrkuLdZ2Wxu
	 nSVNqI3PywcQ8r4ri3NsLp1qM5HM4ujtpQ/J2A0pDiLTBiAdWbdtQCbTLxM2/qQQY6
	 HtNTJdjjstXxHspNswrHO8uFbX3VHfHzTY12f4BY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727415AbfFGGuG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Jun 2019 02:50:06 -0400
Received: from mga09.intel.com ([134.134.136.24]:58904 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726891AbfFGGuG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jun 2019 02:50:06 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 06 Jun 2019 23:50:05 -0700
X-ExtLoop1: 1
Received: from pipin.fi.intel.com (HELO pipin) ([10.237.72.175])
  by fmsmga007.fm.intel.com with ESMTP; 06 Jun 2019 23:50:03 -0700
From:   Felipe Balbi <balbi@kernel.org>
To:     Anurag Kumar Vulisha <anuragku@xilinx.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     "linux-usb\@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel\@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "v.anuragkumar\@gmail.com" <v.anuragkumar@gmail.com>
Subject: RE: [PATCH] usb: dwc3: gadget: Correct the logic for finding last SG entry
In-Reply-To: <BYAPR02MB559181C009B74446A797838DA7170@BYAPR02MB5591.namprd02.prod.outlook.com>
References: <1559141985-17104-1-git-send-email-anurag.kumar.vulisha@xilinx.com> <87y32gcvc1.fsf@linux.intel.com> <BYAPR02MB559181C009B74446A797838DA7170@BYAPR02MB5591.namprd02.prod.outlook.com>
Date:   Fri, 07 Jun 2019 09:49:59 +0300
Message-ID: <87ftoldh48.fsf@linux.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha256; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable


Hi,

Anurag Kumar Vulisha <anuragku@xilinx.com> writes:
>>> The dma_map_sg() merges sg1 & sg2 memory regions into sg1-
>>>dma_address.
>>> Similarly sg3 & sg4 into sg2->dma_address, sg5 & sg6 into the
>>> sg3->dma_address and sg6 & sg8 into sg4->dma_address. Here the
>>memory
>>> regions are merged but the page_link properties like SG_END are not
>>> retained into the merged sgs.
>>
>>isn't this a bug in the scatterlist mapping code? Why doesn't it keep
>>SG_END?
>>
>
> Thanks for providing your comment.
>
> I don't think it is a bug, instead I feel some enhancement needs to be do=
ne in
> dma-mapping code.
>
> SG_END represents the last sg entry in the sglist and it is correctly get=
ting
> set to the last sg entry.
>
> The issue happens only when 2 or more sg entry pages are merged into
> contiguous dma-able address and sg_is_last() is used to find the last sg =
entry
> with valid dma address.

Right, and that's something that's bound to happen. I'm arguing that, perha=
ps,
dma API should move SG_END in case entries are merged.

> I think that along with sg_is_last() a new flag (SG_DMA_END) and function
> (something like sg_dma_is_last() ) needs to be added into dma-mapping cod=
e for
> identifying the last valid sg entry with valid dma address. So that we can
> make use of that function instead of sg_is_last().

Sure, propose a patch to DMA API.

=2D-=20
balbi

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEElLzh7wn96CXwjh2IzL64meEamQYFAlz6CRcACgkQzL64meEa
mQajdhAAntC8glHbh2DnwAAgQ8p1tZk9gyf6O6NTuCA9lhoRVF7Uw9E9cPlNijio
V6ah4z+7QY6XL1JiZaFg8no8dAKn0G1DOsCC2p/9kT1dS7a4LqKwe/lct3yLFm3E
CE9cRyY+TET7yDjLZH00aDTf+kTk0ep2Hm6RlgZ31MmiW/YR39H8ZzyonkHoKtbT
Eth3C8i4wjIueWf5Lr5JhSzo0rrUUWcWLyjrkbJsUp/S7oI5iPreZ0Sz9gNtRcZu
2A6di/EircsjDnSIf8il/M4p9fzjt/eoXFbB/to8tA9P5pR4qMjEHlriRHZdrv9D
SapgloHjUGCCRCAjyL++f0EXDG693ytkU9GUrkXERwjVFws7lL2gnnC5hrcugzRN
7VTBf6yR9ehOB+1HycZ6kC1eNzZBbYibnNSWzM5SxGIYlTva6yWZzYvJfFp30aVA
j5r5qSweiYhC/7MKI5TQMDfWo6jBM9WEL/V2w1RqS4HbosGuD/fVIeQZ9ihJItVo
7UQfmLJQXMfoWD1wkD4tkFOsXCZIZiFHa9CwXTrCCzPAaBhpYhBokRZhV1pa9lfo
w3vx/R0kHnngsDZUD5RwnI5AXhoLnuGUbF8cpkGOPGAONjTDsPFtXKrlF9+70oCd
pof7AtSKznbHHDawmd/Kq8mKW4A0ZZGcB83oj0C80ze2LhFRcss=
=Z89T
-----END PGP SIGNATURE-----
--=-=-=--
