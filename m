Return-Path: <SRS0=Exau=WQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6120C3A589
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 17:24:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 90C3422CE3
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 17:24:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1566321891;
	bh=32bftUSKN3Wtl2ZUSwOigociAvrqIpLWLd4sbLVVuNs=;
	h=Subject:To:Cc:References:From:Date:In-Reply-To:List-ID:From;
	b=j0O+4Cb06DFVujf/vMvZ5bfUFlpHq92PlBaf/GcUsyLpkzmUr1DlzcppFa7U/KuQc
	 fMMNtttV4BLN3g8yJ2mY0GwTzP/HLYPXDcP8kNQZqPyZMOVHrdXO9UqhYpoSSRR13S
	 rXVJgs3TXDLaQvkHt1d6muL/xVeefkjl3kLTNe1o=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729980AbfHTRYu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Aug 2019 13:24:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:47980 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725971AbfHTRYu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Aug 2019 13:24:50 -0400
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net [24.9.64.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4D3702054F;
        Tue, 20 Aug 2019 17:24:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566321889;
        bh=32bftUSKN3Wtl2ZUSwOigociAvrqIpLWLd4sbLVVuNs=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=mNf7pt3nluqjn7wPRl9oxtXsVnuSZaSCBUZomyCyPzzn86pMm1C66eV2ovN537fzs
         twDIX2TwIIhksR2hUFeG2rerO7ZyNg5kILiIjocQMh8JrJt3TqkiQ7ehTmVji22V5G
         ZtcCI3OBDRsHFfQ2uCdN2ixEmqYcj9rmuODIJfnw=
Subject: Re: [PATCH v13 00/18] kunit: introduce KUnit, the Linux kernel unit
 testing framework
To:     Brendan Higgins <brendanhiggins@google.com>,
        frowand.list@gmail.com, gregkh@linuxfoundation.org,
        jpoimboe@redhat.com, keescook@google.com,
        kieran.bingham@ideasonboard.com, mcgrof@kernel.org,
        peterz@infradead.org, robh@kernel.org, sboyd@kernel.org,
        tytso@mit.edu, yamada.masahiro@socionext.com
Cc:     devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org,
        kunit-dev@googlegroups.com, linux-doc@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kbuild@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-nvdimm@lists.01.org, linux-um@lists.infradead.org,
        Alexander.Levin@microsoft.com, Tim.Bird@sony.com,
        amir73il@gmail.com, dan.carpenter@oracle.com, daniel@ffwll.ch,
        jdike@addtoit.com, joel@jms.id.au, julia.lawall@lip6.fr,
        khilman@baylibre.com, knut.omang@oracle.com, logang@deltatee.com,
        mpe@ellerman.id.au, pmladek@suse.com, rdunlap@infradead.org,
        richard@nod.at, rientjes@google.com, rostedt@goodmis.org,
        wfg@linux.intel.com, Bjorn Helgaas <bhelgaas@google.com>,
        shuah <shuah@kernel.org>
References: <20190814055108.214253-1-brendanhiggins@google.com>
From:   shuah <shuah@kernel.org>
Message-ID: <5b880f49-0213-1a6e-9c9f-153e6ab91eeb@kernel.org>
Date:   Tue, 20 Aug 2019 11:24:45 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190814055108.214253-1-brendanhiggins@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/13/19 11:50 PM, Brendan Higgins wrote:
> ## TL;DR
> 
> This revision addresses comments from Stephen and Bjorn Helgaas. Most
> changes are pretty minor stuff that doesn't affect the API in anyway.
> One significant change, however, is that I added support for freeing
> kunit_resource managed resources before the test case is finished via
> kunit_resource_destroy(). Additionally, Bjorn pointed out that I broke
> KUnit on certain configurations (like the default one for x86, whoops).
> 
> Based on Stephen's feedback on the previous change, I think we are
> pretty close. I am not expecting any significant changes from here on
> out.
> 

Hi Brendan,

I found checkpatch errors in one or two patches. Can you fix those and
send v14.

thanks,
-- Shuah
