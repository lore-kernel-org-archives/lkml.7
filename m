Return-Path: <SRS0=s1fu=UU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEE63C43613
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Jun 2019 11:23:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7CAC421537
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Jun 2019 11:23:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="FAzewMiX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726608AbfFULXk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Jun 2019 07:23:40 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:44702 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726360AbfFULXj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jun 2019 07:23:39 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20190621112338euoutp01677e65c536811b62e3b0c6de9879bd2e~qMu3wkLzZ0440404404euoutp01H
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jun 2019 11:23:38 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20190621112338euoutp01677e65c536811b62e3b0c6de9879bd2e~qMu3wkLzZ0440404404euoutp01H
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1561116218;
        bh=9WXJOsmsdpNjqD2mqazjYllrCAaz0beIZ+leLl14Ekg=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=FAzewMiXZBYrAWvx++nVCLwM1srZNuSPqfPQnH/H4L3VkhlwVdCVlcyLJETA/hszj
         HoM5UaqiNtwrd42hacgWXwWXt1v2x/uiAOyS66vqQf1LjlqAcTgeOsF8Eq7DlIZivE
         nCivZQwoqwkZImgV5NVU8tFYYQz0ziN1nv2xG5K0=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20190621112337eucas1p13a38adba7ca38ac2372c2dd23145a8b8~qMu3EFE6W2737227372eucas1p1f;
        Fri, 21 Jun 2019 11:23:37 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id 24.6C.04325.93EBC0D5; Fri, 21
        Jun 2019 12:23:37 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20190621112336eucas1p2c3730a3a45ab0c47cf15e8794464dc06~qMu2UpgN41885518855eucas1p20;
        Fri, 21 Jun 2019 11:23:36 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20190621112336eusmtrp13053b6817d1ea4f644ee5476ad65c0d1~qMu2GngNn1174011740eusmtrp10;
        Fri, 21 Jun 2019 11:23:36 +0000 (GMT)
X-AuditID: cbfec7f5-b75ff700000010e5-58-5d0cbe394270
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 6E.CC.04146.83EBC0D5; Fri, 21
        Jun 2019 12:23:36 +0100 (BST)
Received: from [106.120.51.71] (unknown [106.120.51.71]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20190621112336eusmtip1cea6d5fa1d3eda4575b6c7d309ed8555~qMu1wQQTv1114311143eusmtip1M;
        Fri, 21 Jun 2019 11:23:36 +0000 (GMT)
Subject: Re: [PATCH] video: fbdev: pvr2fb: fix link error for
 pvr2fb_pci_exit
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     YueHaibing <yuehaibing@huawei.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Linux Fbdev development list <linux-fbdev@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
From:   Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Message-ID: <cabdf0c8-8c8a-aa40-37ed-d3d11c9d3bb8@samsung.com>
Date:   Fri, 21 Jun 2019 13:23:33 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <CAK8P3a3qTCnJn7X1msg03Av71aZmmN8YB=WNs0JfzYoMH+uL-w@mail.gmail.com>
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrAKsWRmVeSWpSXmKPExsWy7djP87qW+3hiDS7O4LeYs34Nm8XfScfY
        La58fc9msf/pcxaLE30fWC0u75rDZnHn63MWB3aP378mMXq0HHnL6rF4z0smjxMzfrN43O8+
        zuTxeZNcAFsUl01Kak5mWWqRvl0CV0bflBXsBWfYKk5Oe8TYwLiNtYuRk0NCwETi2MedjF2M
        XBxCAisYJf68+s8M4XxhlJi9pI8FwvnMKLFw5W5GmJZ3U99BtSxnlFg9aT+U85ZRYkXPRSaQ
        KmEBf4m239fYQGwRAUWJqS+egc1lFpjLJPHxxgqwUWwCVhIT21eB2bwCdhJXrp4AKuLgYBFQ
        lTj2TwgkLCoQIXH/2AZWiBJBiZMzn7CA2JwCgRLLbz1iBrGZBcQlbj2ZzwRhy0tsfzuHGeLS
        Q+wS9555QtguEld3L4b6QFji1fEt7BC2jMTpyT1gb0oIrGOU+NvxghnC2c4osXzyPzaIKmuJ
        w8cvsoIcxyygKbF+lz5E2FFi1fatTCBhCQE+iRtvBSFu4JOYtG06M0SYV6KjTQiiWk1iw7IN
        bDBru3auZJ7AqDQLyWezkHwzC8k3sxD2LmBkWcUonlpanJueWmycl1quV5yYW1yal66XnJ+7
        iRGYjk7/O/51B+O+P0mHGAU4GJV4eA/M4o4VYk0sK67MPcQowcGsJMLLk8MTK8SbklhZlVqU
        H19UmpNafIhRmoNFSZy3muFBtJBAemJJanZqakFqEUyWiYNTqoGxcnre4WkLv/3JdCiY8Gj3
        uU5H7blxVyPMH3/6uOn2tvkq8nfSbzzJM89j7vrrPVujSTVOylF6aVy9qsfrG69sJzac3uZ6
        S3WT7Avn09/4tUp/Ovld3lA/tUA5pNJWQv/TtHybP2EGZqpvP00Nbo//vir9a5HMk/MLZ8ao
        b2v/f52npD/54Dd7JZbijERDLeai4kQAdTenmkMDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrEIsWRmVeSWpSXmKPExsVy+t/xu7oW+3hiDXYcUrCYs34Nm8XfScfY
        La58fc9msf/pcxaLE30fWC0u75rDZnHn63MWB3aP378mMXq0HHnL6rF4z0smjxMzfrN43O8+
        zuTxeZNcAFuUnk1RfmlJqkJGfnGJrVK0oYWRnqGlhZ6RiaWeobF5rJWRqZK+nU1Kak5mWWqR
        vl2CXkbflBXsBWfYKk5Oe8TYwLiNtYuRk0NCwETi3dR3jF2MXBxCAksZJWbcns7excgBlJCR
        OL6+DKJGWOLPtS42iJrXjBI9PQ/ZQBLCAr4SM978ZgexRQQUJaa+eMYMUsQsMJdJ4u7KHhaI
        jhYmiZ6jv5lAqtgErCQmtq9iBLF5Bewkrlw9wQyyjUVAVeLYPyGQsKhAhMSZ9ytYIEoEJU7O
        fAJmcwoESiy/9YgZxGYWUJf4M+8SlC0ucevJfCYIW15i+9s5zBMYhWYhaZ+FpGUWkpZZSFoW
        MLKsYhRJLS3OTc8tNtQrTswtLs1L10vOz93ECIy/bcd+bt7BeGlj8CFGAQ5GJR7eA7O4Y4VY
        E8uKK3MPMUpwMCuJ8PLk8MQK8aYkVlalFuXHF5XmpBYfYjQF+m0is5Rocj4wNeSVxBuaGppb
        WBqaG5sbm1koifN2CByMERJITyxJzU5NLUgtgulj4uCUamD0cD+gdufuxGmBdxs0np45vKf4
        7Oc9D9+zbLwz1Xpi+KUZxyVNr2cmZhRk957e0u66PeNBFWfwPxcxof/P7zIVifxmuMO1wGeO
        9Xp/h7lxzVYMd0x//i85Y3r5daPvy7+WZaaWZxlL9pb71yx8rta7++Kh587Trhvv5NML/Xmh
        +WlI3Zd9E2YpKrEUZyQaajEXFScCAK5PMuDVAgAA
X-CMS-MailID: 20190621112336eucas1p2c3730a3a45ab0c47cf15e8794464dc06
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20190617131645epcas1p3340c80f9e83af93bcbb4c68128b1ea44
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190617131645epcas1p3340c80f9e83af93bcbb4c68128b1ea44
References: <CGME20190617131645epcas1p3340c80f9e83af93bcbb4c68128b1ea44@epcas1p3.samsung.com>
        <20190617131624.2382303-1-arnd@arndb.de>
        <1628618a-7cf6-506e-9d87-c0966a99fbea@samsung.com>
        <CAK8P3a3qTCnJn7X1msg03Av71aZmmN8YB=WNs0JfzYoMH+uL-w@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 6/21/19 1:05 PM, Arnd Bergmann wrote:
> On Fri, Jun 21, 2019 at 12:58 PM Bartlomiej Zolnierkiewicz
> <b.zolnierkie@samsung.com> wrote:
>>
>> On 6/17/19 3:16 PM, Arnd Bergmann wrote:
>>> When the driver is built-in for PCI, we reference the exit function
>>> after discarding it:
>>>
>>> `pvr2fb_pci_exit' referenced in section `.ref.data' of drivers/video/fbdev/pvr2fb.o: defined in discarded section `.exit.text' of drivers/video/fbdev/pvr2fb.o
>>>
>>> Just remove the __exit annotation as the easiest workaround.
>>
>> Don't we also need to fix pvr2fb_dc_exit() for CONFIG_SH_DREAMCAST=y case?
> 
> I think that's correct, yes. Can you fix that up when applying the patch?

Sure.

I've queued the patch for v5.3, thanks!

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics
