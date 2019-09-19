Return-Path: <SRS0=X8En=XO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86A90C4CEC4
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Sep 2019 19:21:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 45F2C21A49
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Sep 2019 19:21:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="VhT/g9WR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392341AbfISTVt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Sep 2019 15:21:49 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:51180 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389902AbfISTVt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Sep 2019 15:21:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=/XlplTmXoDT064kOqQ4CCeaS0kkcfeOo8hmExrzg4C0=; b=VhT/g9WRYqLw+/Ava0COWIaOc
        auGUhJvlFY0gV6YYwndDj/GH6m1abxR5lRJmAefyk00q6XUd7075Bb7Lpz2icIJYGSERnxHtwcg0E
        1iJqe/8OUJYgUKkWlW7SYPKLFGHc7Zb49E8D1me2Tyt4ygYHSAA6RqHXARt0hTzDSk3DUBIS0r3E6
        vqWzmcgNhOJBlzlsr4OfiX02jGbhjfxHtUMmfJryp8UKA5MtSDjNiIty7Qqk6ESKGcD1QQZDp5l0A
        1tK1yFxe5/T2+6gDmmlxk7bdF+KgDnPKdF3bHXG3m7i38D0o41Lfb2SqUhXm9XMRzf39O33hcuKcB
        bNaSpwvsQ==;
Received: from [2601:1c0:6280:3f0::9a1f]
        by bombadil.infradead.org with esmtpsa (Exim 4.92.2 #3 (Red Hat Linux))
        id 1iB1zw-00077Q-Iu; Thu, 19 Sep 2019 19:21:48 +0000
Subject: Re: linux-next: Tree for Sep 18 (objtool)
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     Mark Brown <broonie@kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
References: <20190918221053.GV2596@sirena.co.uk>
 <be0fb087-5fb4-a790-90dd-cc2af62419e7@infradead.org>
 <20190919165118.lffzvrl5efbpnvux@treble>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <8dc0ef20-c776-bfdc-de31-1759125c77e9@infradead.org>
Date:   Thu, 19 Sep 2019 12:21:46 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190919165118.lffzvrl5efbpnvux@treble>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/19/19 9:51 AM, Josh Poimboeuf wrote:
> On Wed, Sep 18, 2019 at 09:04:21PM -0700, Randy Dunlap wrote:
>> On 9/18/19 3:10 PM, Mark Brown wrote:
>>> Hi all,
>>>
>>> Changes since 20190917:
>>>
>>
>> on x86_64:
>>
>> drivers/gpu/drm/i915/gem/i915_gem_execbuffer.o: warning: objtool: i915_gem_execbuffer2_ioctl()+0x2fb: call to gen8_canonical_addr() with UACCESS enabled
>>
>> using
>>> gcc --version
>> gcc (SUSE Linux) 7.4.1 20190424 [gcc-7-branch revision 270538]
>>
>> .o and .config files are attached.
> 
> Does this fix it?

This patch produces this message:

drivers/gpu/drm/i915/gem/i915_gem_execbuffer.o: warning: objtool: i915_gem_execbuffer2_ioctl()+0x2fb: call to sign_extend64.constprop.20() with UACCESS enabled


> diff --git a/drivers/gpu/drm/i915/gem/i915_gem_execbuffer.c b/drivers/gpu/drm/i915/gem/i915_gem_execbuffer.c
> index b5f6937369ea..7e111cb5b14b 100644
> --- a/drivers/gpu/drm/i915/gem/i915_gem_execbuffer.c
> +++ b/drivers/gpu/drm/i915/gem/i915_gem_execbuffer.c
> @@ -284,7 +284,7 @@ struct i915_execbuffer {
>   * canonical form [63:48] == [47]."
>   */
>  #define GEN8_HIGH_ADDRESS_BIT 47
> -static inline u64 gen8_canonical_addr(u64 address)
> +static __always_inline u64 gen8_canonical_addr(u64 address)
>  {
>  	return sign_extend64(address, GEN8_HIGH_ADDRESS_BIT);
>  }
> 


-- 
~Randy
