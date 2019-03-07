Return-Path: <SRS0=uyI7=RK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D617C10F03
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 15:21:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E31920840
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 15:21:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b="tdL9DOC6";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="6P1ihIWD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726556AbfCGPVx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Mar 2019 10:21:53 -0500
Received: from wout2-smtp.messagingengine.com ([64.147.123.25]:48985 "EHLO
        wout2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726166AbfCGPVw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Mar 2019 10:21:52 -0500
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailout.west.internal (Postfix) with ESMTP id 2B56236C0;
        Thu,  7 Mar 2019 10:21:51 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Thu, 07 Mar 2019 10:21:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm3; bh=ZWOjpVoFygjKpj3QCFIE67u4a+B
        gT9KskygU8uLvIpc=; b=tdL9DOC60Xq66uJCV7IU+QBkWsfemp43Wb6IVfmsBzG
        9QDfFk0q1rB+H6zHNmuJEz+fzIeVk0RpqdHj2FoGXwS8lxV+DixzoMKVP3RoPow5
        ObPc0XT1Xb4JKshvfjxUVIkq94hWVjX1sLL4SSHKo8wW8/wP7E9WlO2z9KjX73+u
        0RgeEqEuOehyeO0QXeciKzY79FQRrPvZVhTFO77qNpZM1i4Gn97GtqNiZVOFCP3Q
        bRDrehYHrFpIeIomOOLMu5neOVYs7FczOclcrO172Hubibv+iHCsEaKylWJE/ygV
        mHYHeOZ53DbnTFJ+y5hgl4w3jxUo7hL1qUw2gR9OuUg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=ZWOjpV
        oFygjKpj3QCFIE67u4a+BgT9KskygU8uLvIpc=; b=6P1ihIWDEH2f7JITupxm3S
        +v7mm6RTpmKEHXUs6x8ILvvdCU6R3N0x8Njt9qCIGJu7wHJaEwVVObbmRWtrblzf
        En5Snv1yx8xHAcfyMqQs0dCpCwIEG33UvsOcg/QECQ6jso/wxDqLyYoYOFFBjaKC
        WGa8cSBEKGuZ7aXAKybaIFcy8PBC916Xw3GbucXv5iSrYypSMWUNgcq39rRLNTIL
        WwCYTnX1QJjxU4Q/38LaL8lK/ZZYVItTas8oKx2o5aSSmFiuuydnC/Iy/KYlAbvI
        bNa8f78oWReaB8V1iKZJfHijKfC1oBHhrWv6ldxhLqmP266pwcECL8BO1r6JjW9w
        ==
X-ME-Sender: <xms:DjeBXIQQv0yao2CIrE75CKxqxq-aH-aeKgUS2JNE-SzzKp_waUkYEw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedutddrfeekgdejjecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvuffkfhggtggujggfsehttdertddtredvnecuhfhrohhmpefirhgvghcu
    mffjuceoghhrvghgsehkrhhorghhrdgtohhmqeenucfkphepkeefrdekiedrkeelrddutd
    ejnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgrhgvgheskhhrohgrhhdrtghomhenucev
    lhhushhtvghrufhiiigvpedu
X-ME-Proxy: <xmx:DjeBXAuUjlEiS5zs2L6mDriK6KjBG2U4fZgT5xtgsng6iiqyIZmMyw>
    <xmx:DjeBXEy7oLhNt31BqqJ3gHs6jZnkPbt7tyPDADhFbE4mNtqY84U4vw>
    <xmx:DjeBXAfEdXEjBVrkkwdsTYyaZg2N3lXTsxVGGWcESlZXsGIGtPsblw>
    <xmx:DjeBXKzpeKkD5uQ87SX8jEkGO4OeKBsik-E_mQq0DooY74qKhO3upQ>
Received: from localhost (5356596b.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        by mail.messagingengine.com (Postfix) with ESMTPA id A06E810336;
        Thu,  7 Mar 2019 10:21:49 -0500 (EST)
Date:   Thu, 7 Mar 2019 16:21:47 +0100
From:   Greg KH <greg@kroah.com>
To:     Gao Xiang <gaoxiang25@huawei.com>
Cc:     Sasha Levin <sashal@kernel.org>, Chao Yu <yuchao0@huawei.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-erofs@lists.ozlabs.org, stable@vger.kernel.org
Subject: Re: [PATCH for-4.19] staging: erofs: fix mis-acted TAIL merging
 behavior
Message-ID: <20190307152147.GA24453@kroah.com>
References: <20190301212203.5FE0C2084F@mail.kernel.org>
 <20190307053404.29108-1-gaoxiang25@huawei.com>
 <20190307122539.GD21325@kroah.com>
 <5b7e1914-f8e5-da3d-4492-17d6afc00fb1@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5b7e1914-f8e5-da3d-4492-17d6afc00fb1@huawei.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 07, 2019 at 09:04:06PM +0800, Gao Xiang wrote:
> Hi Greg,
> 
> On 2019/3/7 20:25, Greg KH wrote:
> > On Thu, Mar 07, 2019 at 01:34:04PM +0800, Gao Xiang wrote:
> >> commit a112152f6f3a2a88caa6f414d540bd49e406af60 upstream.
> >>
> >> EROFS has an optimized path called TAIL merging, which is designed
> >> to merge multiple reads and the corresponding decompressions into
> >> one if these requests read continuous pages almost at the same time.
> >>
> >> In general, it behaves as follows:
> >>  ________________________________________________________________
> >>   ... |  TAIL  .  HEAD  |  PAGE  |  PAGE  |  TAIL    . HEAD | ...
> >>  _____|_combined page A_|________|________|_combined page B_|____
> >>         1  ]  ->  [  2                          ]  ->  [ 3
> >> If the above three reads are requested in the order 1-2-3, it will
> >> generate a large work chain rather than 3 individual work chains
> >> to reduce scheduling overhead and boost up sequential read.
> >>
> >> However, if Read 2 is processed slightly earlier than Read 1,
> >> currently it still generates 2 individual work chains (chain 1, 2)
> >> but it does in-place decompression for combined page A, moreover,
> >> if chain 2 decompresses ahead of chain 1, it will be a race and
> >> lead to corrupted decompressed page. This patch fixes it.
> >>
> >> Fixes: 3883a79abd02 ("staging: erofs: introduce VLE decompression support")
> >> Cc: <stable@vger.kernel.org> # 4.19+
> >> Signed-off-by: Gao Xiang <gaoxiang25@huawei.com>
> >> Reviewed-by: Chao Yu <yuchao0@huawei.com>
> >> ---
> >>  drivers/staging/erofs/unzip_vle.c | 69 +++++++++++++++++++++++++--------------
> >>  1 file changed, 44 insertions(+), 25 deletions(-)
> >>
> > 
> > thanks for the backport, now applied.
> 
> Yes, it seems that Sasha's bot cannot cherry-pick it directly,
> therefore I made this patch for 4.19 by hand...
> 
> BTW, there is another patch called "staging: erofs: compressed_pages should not be accessed again after freed"
> in the same condition... And I also send 4.19 and 4.20 version to stable mailing list,
> could you also kindly check them out?

Yes, please give me a chance to catch up on stable pending patches to
process:

	$ mdfrm -c ~/mail/stable/
	585 messages in /home/gregkh/mail/stable/

You are in good company :)

greg k-h
