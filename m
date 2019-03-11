Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00AB7C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 10:15:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D2AE20657
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 10:15:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="caIrEN1o"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727117AbfCKKPU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 06:15:20 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:60152 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726623AbfCKKPT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 06:15:19 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20190311101517euoutp0214691227233eeb89f4d7e04c5ad13c60~K4AFUkDnv2513225132euoutp02X
        for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2019 10:15:17 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20190311101517euoutp0214691227233eeb89f4d7e04c5ad13c60~K4AFUkDnv2513225132euoutp02X
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1552299317;
        bh=MsROilAY3e2AMHz1rt4P12WlOhRCVMwuT+WipHZDSew=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=caIrEN1ogZA3yOs036uaNBv3swjPMLlq4R+1ztPBMHnOn0A/WO8FCC244hUQRNuie
         OuOYcGtdaJY8GiDSUcCTVNi9YdAPlb5hcaH/6G2/nN9ccjJLdpW8UQnu5XcZq3LDbX
         O+R1U49QCj9yQ+Qn8HvZ823BeP6yIRTr+GvsO3dA=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20190311101517eucas1p21d55d8d42e19f783eb87bb2af7cf33ff~K4AElkAdi1156911569eucas1p2v;
        Mon, 11 Mar 2019 10:15:17 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id 2F.22.04441.435368C5; Mon, 11
        Mar 2019 10:15:16 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20190311101516eucas1p28dd43abc5e06299e7afb8c9d784c69ce~K4ADlYbLW1153811538eucas1p2t;
        Mon, 11 Mar 2019 10:15:16 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20190311101516eusmtrp2eee3a5345787c7ea14caf694e189b896~K4ADkubhA0267302673eusmtrp2a;
        Mon, 11 Mar 2019 10:15:16 +0000 (GMT)
X-AuditID: cbfec7f2-5e3ff70000001159-72-5c8635348596
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id FC.F9.04128.335368C5; Mon, 11
        Mar 2019 10:15:15 +0000 (GMT)
Received: from [106.116.147.30] (unknown [106.116.147.30]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20190311101515eusmtip26a306e33916433ae95933e2a514e7f7e~K4ADDACnE2584325843eusmtip2Z;
        Mon, 11 Mar 2019 10:15:15 +0000 (GMT)
Subject: Re: REGRESSION: dwc2: gadget: Add scatter-gather mode
To:     John Stultz <john.stultz@linaro.org>
Cc:     Felipe Balbi <felipe.balbi@linux.intel.com>,
        Minas Harutyunyan <Minas.Harutyunyan@synopsys.com>,
        Artur Petrosyan <Arthur.Petrosyan@synopsys.com>,
        Linux USB List <linux-usb@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Tom Gall <tom.gall@linaro.org>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Andrzej Pietrasiewicz <andrzejtp2010@gmail.com>
From:   Marek Szyprowski <m.szyprowski@samsung.com>
Message-ID: <fe3b207e-1200-4a76-8c10-28655029f16d@samsung.com>
Date:   Mon, 11 Mar 2019 11:15:14 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
        Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <CALAqxLUZKinhCasO4rXBJuip3bOo+JCovWLrHYPBPTopf6d7Vw@mail.gmail.com>
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrGKsWRmVeSWpSXmKPExsWy7djP87ompm0xBh93GlrcWneO1WLFmieM
        Fr13TCzm30yyOPNb1+LyrjlsFouWtTJbvJtym9niypkOJgdOj52z7rJ73Lm2h81j3slAj74t
        qxg9tuz/zOjxeZNcAFsUl01Kak5mWWqRvl0CV8bex0tZC6bKVew98IKxgfGARBcjJ4eEgInE
        hBlrGLsYuTiEBFYwSmw88hvK+cIosWX3RXYI5zOjxKSvR5lhWvZs/s8IYgsJLGeUmPNLBqLo
        PaNEw7oGVpCEsICdRPvZzywgtoiAhsTCJVeZQIqYBR4zSTT+PwWWYBMwlOh628UGYvMCNbQd
        +8QOYrMIqEosv/gTyObgEBWIkTi0uAyiRFDi5MwnYK2cAoESJ68tBbOZBeQltr+dwwxhi0vc
        ejIfbJeEwD52iU+rZ7BDXO0isfPfATYIW1ji1fEtUHEZif87YRqaGSXaZ8xih3B6GCW2ztkB
        1WEtcfj4RVaQi5gFNCXW79KHCDtKfD//BSwsIcAnceOtIMQRfBKTtk1nhgjzSnS0CUFUq0nM
        Or4Obu3BC5eYJzAqzULy2iwk78xC8s4shL0LGFlWMYqnlhbnpqcWG+allusVJ+YWl+al6yXn
        525iBKam0/+Of9rB+PVS0iFGAQ5GJR7ehOTWGCHWxLLiytxDjBIczEoivAmybTFCvCmJlVWp
        RfnxRaU5qcWHGKU5WJTEeasZHkQLCaQnlqRmp6YWpBbBZJk4OKUaGGfMMv2q6efiWDb5UKhb
        rn/xXKlsgzuV0+yYpv6dtDTsgpfqorKsPbL7Kywsf149tVs7+namy8aeR/yh24NunDgRfbzR
        Z5/knTO5n26pVb3xNpZaPfvk3bWl5lXrPfuPOIRqp73RFD2vdyj0woNj4lu385+vsygQ1aqX
        EF65cdOCJYJ71nMxSymxFGckGmoxFxUnAgCiIzzfSQMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrFIsWRmVeSWpSXmKPExsVy+t/xe7rGpm0xBv+u2ljcWneO1WLFmieM
        Fr13TCzm30yyOPNb1+LyrjlsFouWtTJbvJtym9niypkOJgdOj52z7rJ73Lm2h81j3slAj74t
        qxg9tuz/zOjxeZNcAFuUnk1RfmlJqkJGfnGJrVK0oYWRnqGlhZ6RiaWeobF5rJWRqZK+nU1K
        ak5mWWqRvl2CXsbex0tZC6bKVew98IKxgfGARBcjJ4eEgInEns3/GbsYuTiEBJYySixtvsUK
        kZCRODmtAcoWlvhzrYsNougto0TH7FPsIAlhATuJ9rOfWUBsEQENiYVLrjKBFDELPGeS2Nz9
        gxWiYwmjxLl1n9lAqtgEDCW63naB2bxA3W3HPoFNYhFQlVh+8SeYLSoQI/Hh7g0miBpBiZMz
        n4Bt4BQIlDh5bSmYzSygLvFn3iVmCFteYvvbOVC2uMStJ/OZJjAKzULSPgtJyywkLbOQtCxg
        ZFnFKJJaWpybnltspFecmFtcmpeul5yfu4kRGI/bjv3csoOx613wIUYBDkYlHl6OxNYYIdbE
        suLK3EOMEhzMSiK8CbJtMUK8KYmVValF+fFFpTmpxYcYTYGem8gsJZqcD0wVeSXxhqaG5haW
        hubG5sZmFkrivOcNKqOEBNITS1KzU1MLUotg+pg4OKUaGHn7Jc7ozH/lrFcWcV378AWxhW3y
        lvN2cr2SOj+nkjmotaB7kcSnxi1LTyqvmXen2Mng4aum8n/294yVLLZPnMN0sVBOIyTDKf/h
        35/ie3xMnEuTmQ/0sZ30EikIKcsRzb4n1jL9ykWG2jsb5Dq2/f3kcE9cKngpr4Fw2sGPultd
        tq9MVV+mrMRSnJFoqMVcVJwIABDwlnrdAgAA
X-CMS-MailID: 20190311101516eucas1p28dd43abc5e06299e7afb8c9d784c69ce
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20190308205332epcas1p181370b12f611fd746d333a557a1ddb48
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190308205332epcas1p181370b12f611fd746d333a557a1ddb48
References: <CGME20190308205332epcas1p181370b12f611fd746d333a557a1ddb48@epcas1p1.samsung.com>
        <CALAqxLUZKinhCasO4rXBJuip3bOo+JCovWLrHYPBPTopf6d7Vw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi John


On 2019-03-08 21:53, John Stultz wrote:
> Hey Andrzej,
>   I just wanted to let you know, trying to boot linus/master on the
> hikey board today, I've been seeing lots of errors on boot (which
> sometimes crash the board, and sometimes doesn't). See the example
> below.
>
> I've bisected the issue down to 10209abe87f5 ("usb: dwc2: gadget: Add
> scatter-gather mode"), and if I revert that change the issue goes
> away.
>
> Looking at the patch, I can't see anything obviously sticking out, but
> let me know if you have anything suggestions you'd like me to test.

I've CCed new Andrzej's email.

Could you tell a bit more how to reproduce this issue? Which USB
function are you running on the target system? I've noticed that you are
using functionfs. Is is possible to get access to the usb function
daemon to reproduce the problem here? Which version of HiKey board are
you using?


> thanks
> -john
>
>
> [   13.088934] functionfs read size 512 > requested size 24, splitting
> request into multiple reads.
> [   13.089029] ------------[ cut here ]------------
> [   13.102665] Trying to vfree() bad address (00000000ecf3404f)
> [   13.108436] WARNING: CPU: 0 PID: 2014 at mm/vmalloc.c:1516 __vunmap+0xe0/0xe8
> [   13.115587] CPU: 0 PID: 2014 Comm: adbd Not tainted
> 5.0.0-08291-ga032141-dirty #897
> [   13.123244] Hardware name: HiKey Development Board (DT)
> [   13.128469] pstate: 80400005 (Nzcv daif +PAN -UAO)
> [   13.133266] pc : __vunmap+0xe0/0xe8
> [   13.136757] lr : __vunmap+0xe0/0xe8
> [   13.140243] sp : ffffff80114d3b40
> [   13.143555] x29: ffffff80114d3b40 x28: ffffffc07333d280
> [   13.148868] x27: ffffffc071b67a38 x26: 00000000000001e8
> [   13.154180] x25: ffffff80114d3ca8 x24: ffffffc07190e400
> [   13.159492] x23: ffffffc0748bca00 x22: ffffff8010ffd000
> [   13.164803] x21: 0000000000000001 x20: ffffff80114d3c98
> [   13.170113] x19: ffffff8010414e74 x18: ffffff8010ffda48
> [   13.175423] x17: 0000000000000000 x16: 0000000000000000
> [   13.180734] x15: ffffff80914d3867 x14: 0000000000000006
> [   13.186044] x13: ffffff80114d3875 x12: ffffff801101c898
> [   13.191371] x11: ffffff801101c000 x10: 0000000005f5e0ff
> [   13.191416] type=1400 audit(16.743:79): avc: denied { read } for
> comm="drmserver" name="enabled" dev="sysfs" ino=5492
> scontext=u:r:drmserver:s0 tcont0
> [   13.196698] x9 : ffffff80114d3800 x8 : 2966343034336663
> [   13.196707] x7 : 6530303030303030 x6 : 0000000000000424
> [   13.196713] x5 : 0000000000000000 x4 : 0000000000000000
> [   13.196718] x3 : 0000000000000001 x2 : 0000000000000001
> [   13.196724] x1 : b357113b3815f700 x0 : 0000000000000000
> [   13.214445] type=1400 audit(17.075:84): avc: denied { read } for
> comm="audioserver" name="enabled" dev="sysfs" ino=5492
> scontext=u:r:audioserver:s0 t0
> [   13.219604] Call trace:
> [   13.219616]  __vunmap+0xe0/0xe8
> [   13.219623]  __vfree+0x24/0x70
> [   13.219635]  vfree+0x20/0x38
> [   13.270258]  ffs_epfile_io.isra.12+0x190/0x6b0
> [   13.274707]  ffs_epfile_read_iter+0xa0/0x168
> [   13.278982]  __vfs_read+0x10c/0x168
> [   13.282471]  vfs_read+0x8c/0x148
> [   13.285700]  ksys_read+0x5c/0xc8
> [   13.288930]  __arm64_sys_read+0x14/0x20
> [   13.292773]  el0_svc_common.constprop.0+0xb0/0x110
> [   13.297461] type=1400 audit(17.075:84): avc: denied { read } for
> comm="audioserver" name="enabled" dev="sysfs" ino=5492
> scontext=u:r:audioserver:s0 t0
> [   13.297570]  el0_svc_handler+0x28/0x78
> [   13.315592] type=1400 audit(17.179:85): avc: denied { read } for
> comm="bootanimation" name="enabled" dev="sysfs" ino=5492
> scontext=u:r:bootanim:s0 tc0
> [   13.319239]  el0_svc+0x8/0xc
> [   13.319245] ---[ end trace 729ab9edfbdb0764 ]---
>
>
Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

