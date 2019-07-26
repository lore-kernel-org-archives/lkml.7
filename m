Return-Path: <SRS0=vtn1=VX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A605C7618B
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 13:49:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CFE7522CD8
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 13:49:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b="ZRlfeWVk";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="lrnJVLcp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388632AbfGZNtj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jul 2019 09:49:39 -0400
Received: from wout1-smtp.messagingengine.com ([64.147.123.24]:47749 "EHLO
        wout1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2387657AbfGZNti (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jul 2019 09:49:38 -0400
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailout.west.internal (Postfix) with ESMTP id 73CC95A5;
        Fri, 26 Jul 2019 09:49:37 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Fri, 26 Jul 2019 09:49:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm1; bh=u25v4jqLdMhcJsCJVGv5xgA4m38
        jD8NRJ0/CYBRLtXg=; b=ZRlfeWVkQj++42bsuWPcVrGpH5F0W/5LyXXK3FOTURy
        HgWl1mKNBLptRdaiOzVjMqqM2Nj9DMujhcLk8cadQlSpynErjzgeuO1//YncVQt8
        3tUjQ8hPodIWoX9uO3YHLCdOxHZcT+q6KDBMp4fCNkaTE6wJ89UA9fN8Yx8IdGcJ
        DHOMBRkwv8D2h80Z1jbL6MaaG43RO/Tx8sFExU6tbnh1s2j8nbjnh4Yit5j5nlpJ
        Y6XypE/7sch06tHQdIIuWpjfcDgmHlD7IlR4kWmR7ETayUhoX9DeQylE7v3UHh0j
        GTNBY+i/H61+nxfHADDCPt69H+QZfLmyMCizHesIFFA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=u25v4j
        qLdMhcJsCJVGv5xgA4m38jD8NRJ0/CYBRLtXg=; b=lrnJVLcpqnbp123eerg9D9
        jf5TtIyK7Dd90270NU7wi8rV/KMjnwiLpBBmDzPIRea+x5sh2hWL/AXoWd86wfMP
        6gSG+3A4LVBHAF1V98Pz2dU6UgqmHQBnh5NOrpiM/nFzmwrgcfR6axihsxdgSGfj
        M98jxGgxwpV8EfVJNxKAPggvlpIs/ABzJ6YBz8+PtL6MDmLznGtNsz2sdjQZj4KG
        VhQdVUgSOw0rZjWbFAD/xsLmoOuydZQq2AtbGFUl4WngOQfaB9+W0UCN3ksuxgQB
        ca0S0zkm6huM0OK3UUnVnBbCbjcr7obSP2OaGfywT/iT6dNRCYKrEeQfhdgAJiPQ
        ==
X-ME-Sender: <xms:8AQ7XZ3VdRCcKb-w-srfkTLKFRUlU9tyJfH37WiwXExg8KNgj71W-w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduvddrkeeggdeilecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvuffkfhggtggujggfsehttdertddtredvnecuhfhrohhmpefirhgvghcu
    mffjuceoghhrvghgsehkrhhorghhrdgtohhmqeenucfkphepkeefrdekiedrkeelrddutd
    ejnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgrhgvgheskhhrohgrhhdrtghomhenucev
    lhhushhtvghrufhiiigvpedu
X-ME-Proxy: <xmx:8AQ7Xc0rOJGI1ujIFz7ECacyWCLKU2I3QehskWuFCDmTxhDdRssk8g>
    <xmx:8AQ7XZeeYjvktOdOKdPsWek4CgLWrqhnHdFIZjWpdQZPPg9HHgvsrQ>
    <xmx:8AQ7XfeKEdxEveQkfXWOo9jZE0p7iiHypQcQNqLwBBkG-FRD-4-Cuw>
    <xmx:8QQ7XYUMNUNpDh3Zt0hSdKLTWAf4ZPcHPqwVbWYx8REXZtT8kWWtFA>
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        by mail.messagingengine.com (Postfix) with ESMTPA id 72408380089;
        Fri, 26 Jul 2019 09:49:36 -0400 (EDT)
Date:   Fri, 26 Jul 2019 15:49:34 +0200
From:   Greg KH <greg@kroah.com>
To:     Vitaly Kuznetsov <vkuznets@redhat.com>
Cc:     stable@vger.kernel.org, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
        Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>
Subject: Re: [PATCH stable-5.2 0/3] KVM: x86: FPU and nested VMX guest reset
 fixes
Message-ID: <20190726134934.GB23085@kroah.com>
References: <20190725120436.5432-1-vkuznets@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190725120436.5432-1-vkuznets@redhat.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 25, 2019 at 02:04:33PM +0200, Vitaly Kuznetsov wrote:
> Few patches were recently marked for stable@ but commits are not
> backportable as-is and require a few tweaks. Here is 5.2 stable backport.
> 
> [PATCHes 2/3 of the series apply as-is, I have them here for completeness]
> 
> Jan Kiszka (1):
>   KVM: nVMX: Clear pending KVM_REQ_GET_VMCS12_PAGES when leaving nested
> 
> Paolo Bonzini (2):
>   KVM: nVMX: do not use dangling shadow VMCS after guest reset
>   Revert "kvm: x86: Use task structs fpu field for user"

All now applied, thanks!

greg k-h
