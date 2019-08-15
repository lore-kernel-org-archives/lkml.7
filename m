Return-Path: <SRS0=gp+X=WL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E886C3A589
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Aug 2019 13:03:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 485E42171F
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Aug 2019 13:03:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="adrM1hoA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732136AbfHONDe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Aug 2019 09:03:34 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:35023 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732124AbfHONDd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Aug 2019 09:03:33 -0400
Received: by mail-ed1-f65.google.com with SMTP id w20so2068215edd.2
        for <linux-kernel@vger.kernel.org>; Thu, 15 Aug 2019 06:03:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:reply-to:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=74bH2SmQhgYL4nliW04v1cPwr1ENv4nzrzwlUA340i8=;
        b=adrM1hoAgeE5lBwya46OKxU3Vrg8NDJO1xKBlXcw7/iVwCSKLlCifcqal/UPbpOR8T
         wsahA0kHhetrbvGzmqsC9UT78wnHWMqRiiI+nY3Cvb8bjM/+uQIsmcsJND2+DMqVNAUU
         D4ymwSww8AsDvcmrq1r1F+i8nsLINgotjhN3gNV+UigKKyBDZbY/O14Q6ByV/By17uxF
         BkXJeAwEHVmenJ2CgqAY+i42cAK/uCXkftuvUc18R5Z5HJJdRoPQdyGK02+40MYGAWuP
         oXDmK03US2TQcbQvphkmOh7ixS3WHFolnewyk3YXEsJAmBI8GXlAL5iwB/E/qRDVeGdI
         4Law==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:reply-to
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=74bH2SmQhgYL4nliW04v1cPwr1ENv4nzrzwlUA340i8=;
        b=OQUcCHxX2IqvixpTYJC4GD2v6PgPtRmtX0J7oLBfFSfwPGBDSI+IZUbTCnKkk1w8xZ
         f49T33nIQxEsC1r55jCSOEjvmY/rCLtaTh+adQK6LYHDUo2m0+lGJtdATJtQHepRM0EE
         Kbr+BUnfqjNGSve7JzQLsh2E+LHpQl8DgZ4Gkx9KH7l2Wiq2hedpNIY8jcgdWfAB9tpi
         fnTPhAJ4LDh3jQ76BNHKainp8EeYuVGxfxyM8+IVbUpcD+Ozx+WQGrzs9xSzKDVccHPr
         N1rW4TbHBsMcPOGpYlsZZt25BnAJ/SPpxKIwQFOBoKNVff0UpIgp7wPmZ0SxiABovHwF
         OMMQ==
X-Gm-Message-State: APjAAAU7pAapVabIeSv/GtBhfcsFwLLtyHcAcBs7CeD5/iloEwqHhFyo
        e3SjVa0JMoZmFruHrrqIgcg=
X-Google-Smtp-Source: APXvYqwKKY9l5f++nu3Klkkl11E291vSmJnAs0+VxRO9Awq0yfCPbKj09OvfDx9CHKBu2G0b5PrYtw==
X-Received: by 2002:a17:906:6c90:: with SMTP id s16mr4445269ejr.62.1565874211362;
        Thu, 15 Aug 2019 06:03:31 -0700 (PDT)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id m32sm550763edc.89.2019.08.15.06.03.30
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 15 Aug 2019 06:03:30 -0700 (PDT)
Date:   Thu, 15 Aug 2019 13:03:28 +0000
From:   Wei Yang <richard.weiyang@gmail.com>
To:     "Schmid, Carsten" <Carsten_Schmid@mentor.com>
Cc:     Wei Yang <richard.weiyang@gmail.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        "bp@suse.de" <bp@suse.de>,
        "dan.j.williams@intel.com" <dan.j.williams@intel.com>,
        "mingo@kernel.org" <mingo@kernel.org>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "osalvador@suse.de" <osalvador@suse.de>,
        "rdunlap@infradead.org" <rdunlap@infradead.org>,
        "richardw.yang@linux.intel.com" <richardw.yang@linux.intel.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v2] kernel/resource.c: invalidate parent when freed
 resource has childs
Message-ID: <20190815130328.yk4cybuuqnzb7xrx@master>
Reply-To: Wei Yang <richard.weiyang@gmail.com>
References: <1565278859475.1962@mentor.com>
 <1565358624103.3694@mentor.com>
 <20190809223831.fk4uyrzscr366syr@master>
 <CAHk-=wi_9sdMxurjZ1MbNnxt-pA=dqoyf8Fdn9aYc8xvjjnTBg@mail.gmail.com>
 <1565794104204.54092@mentor.com>
 <20190814162932.alwo7g4664c2dtp3@master>
 <c925c7d1041f478c99863da56c24b8a7@SVR-IES-MBX-03.mgc.mentorg.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c925c7d1041f478c99863da56c24b8a7@SVR-IES-MBX-03.mgc.mentorg.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 15, 2019 at 08:18:06AM +0000, Schmid, Carsten wrote:
>>>When a resource is freed and has children, the childrens are
>> 
>> s/childrens/children/
>>
>oh, missed that. Too many children ... ;-)
> 
>>>+		__release_child_resources(tmp, warn);
>> 
>> This function will release all the children.
>> 
>> Is this what Linus suggest?
>> 
>> From his code snippet, I just see siblings parent is set to NULL. I may miss
>> some point?
>>
>At the point we are here, there should be no children, and children of
>children at all ...
>So they are all more or less lost in the wild.
>That was why i didn't copy Linus' code 1:1 but reused an already existing
>function doing similar thing.
>It's anyway worth of thinking about this.
>
>What i have in mind here (example):
>Parent: iomem map 0x1000..0x1FFF
>  Child1: iomem map 0x1000..0x17FF
>    Child11: iomem map 0x1000..0x13FF
>    Child12: iomem map 0x1400..0x17FF
>  Child2: iomem map 0x1800..0x1FFF
>    Child21: iomem map 0x1800..0x1BFF
>    Child22: iomem map 0x1C00..0x1FFF
>
>When releasing the parent, how can children 11, 12, 21 and 22 still be valid?
>They don't know about their grandfather died ...
>Looking at the __release_child_resources, i exactly found that all children are
>invalidated/released in the way Linus did for the parent's children list.
>Doesn't it make sense to do the same for all?
>
>Please comment.
>
>> >+static void check_children(struct resource *parent)
>> >+{
>> >+	if (parent->child) {
>> >+		/* warn and release all children */
>> >+		WARN_ONCE(1, "%s: %s has child %s, release all children\n",
>> >+				__func__, parent->name, parent->child-
>> >name);
>> >+		write_lock(&resource_lock);
>> 
>> In previous version, lock is grasped before parent->child is checked.
>> 
>> Not sure why you change the order?
>> 
>To hold the lock as short as possible.
>But yes, you are right, this could lead to problems if releasing of the
>children is done in a parallel thread on a multicore ...
>I'll change that to cover the whole resource access within the lock.
>Not a big thing ...
>

My gut feeling is this is the problem from mal-functional driver, e.g.
xhci-hcd. We do our best to protect core kernel from it instead of do the
cleanup for it.

So my suggestion is to look into why xhci-hcd behave like this and fix that.

>Best regards
>Carsten

-- 
Wei Yang
Help you, Help me
