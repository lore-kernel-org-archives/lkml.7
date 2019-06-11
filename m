Return-Path: <SRS0=TvG7=UK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E051AC43218
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 13:02:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AAA632086D
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 13:02:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oPZoz7Up"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389541AbfFKNCc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Jun 2019 09:02:32 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:35504 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388131AbfFKNCc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jun 2019 09:02:32 -0400
Received: by mail-pf1-f196.google.com with SMTP id d126so7412800pfd.2;
        Tue, 11 Jun 2019 06:02:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:subject:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=RYF8jmWoohaknAxpNSmkAVScav4AJcUimkVoJQxY0o4=;
        b=oPZoz7UpspmDSRDP60yFZFTmgXjX4FyOYwKa4q4wZ/w/lcxofJ1bYofPYAVnjMjzNh
         T1xSeHPQy/NF+HMNDHLcJPkcfMkJfU/RcaklDAK3s35nWtAcVv7JDueu9P85a7aCBC9k
         F3CR+tVrxGah0e7BcVAvYWM3XpxAbCrN4VuuVy7F67t47vLln8oJGRYE4p+j3WEXt/2R
         OOVG5FbU6/2xbMmHufaBHnyBRQjhPukeuPpsEfZQHAlkRQI1k5tcOHGAW39ClmkE1eHg
         bEdWHKDHWxNhu/b1WlJg4lO9w4GuFwNLl6L5onMIq0QEamzcETftvpTFD4FXEgeUXlMO
         0XzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=RYF8jmWoohaknAxpNSmkAVScav4AJcUimkVoJQxY0o4=;
        b=TR9YRnVOCX1CKABVA6j7LQHRzYvoyQC1GAS2XhTwlH32Pf/LI1E1pCwi5TRmIoiNDW
         ocUsLiSeTZc0IS41VdSxBLzq2rHnXbAav9zyIYlvnmaVoRNfbPlkuc3R4/TUVcf8LXcM
         K/wXuVDHoKKc87ALnblMy1Asc7RQ3YaX1jSlq809w3fm7A1u88SRj2ZgaD61j09B74ws
         DxINvhjnO5qBGxfw81t7r4vAG0l36jagABdTwleK951L+0vVxmk/BpiBFjN/XBOl+JFu
         pdzb06l79GUOktlSQDTvA2nHH0keZli4ozgeCVCLp5QJ8oUjFVFaNBDdp2t1qjG0MWti
         4WDg==
X-Gm-Message-State: APjAAAXrgpfxLVd0DMp0Ea48AJkfYNtuVF8QoONrpu1SdlyR7gIrxhFY
        92BH8viccnZ2p8SVhjgSsGxGkkk8SVs=
X-Google-Smtp-Source: APXvYqwOb0S95cl/7KsX0ESLaeUeaojcPDGOqXQQ0d6Vdvy+oGGi8WCHtt08DYRkCgQryg1VfwQ9MA==
X-Received: by 2002:a63:c44f:: with SMTP id m15mr4501065pgg.34.1560258151007;
        Tue, 11 Jun 2019 06:02:31 -0700 (PDT)
Received: from [10.44.0.192] ([103.48.210.53])
        by smtp.gmail.com with ESMTPSA id g15sm27612945pfm.119.2019.06.11.06.02.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 11 Jun 2019 06:02:30 -0700 (PDT)
From:   Greg Ungerer <gregungerer00@gmail.com>
X-Google-Original-From: Greg Ungerer <gerg@linux-m68k.org>
Subject: Re: binfmt_flat cleanups and RISC-V support
To:     Christoph Hellwig <hch@lst.de>
Cc:     Michal Simek <monstr@monstr.eu>,
        linux-arm-kernel@lists.infradead.org, linux-c6x-dev@linux-c6x.org,
        uclinux-h8-devel@lists.sourceforge.jp,
        linux-m68k@lists.linux-m68k.org, linux-riscv@lists.infradead.org,
        linux-sh@vger.kernel.org, linux-xtensa@linux-xtensa.org,
        linux-kernel@vger.kernel.org
References: <20190610212015.9157-1-hch@lst.de>
 <6e5fb7db-1d6f-7d49-553c-edc18f14f641@linux-m68k.org>
 <20190611073802.GB21522@lst.de>
Message-ID: <87039cee-925b-3f50-f29f-94e55ef6e985@linux-m68k.org>
Date:   Tue, 11 Jun 2019 23:02:24 +1000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190611073802.GB21522@lst.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 11/6/19 5:38 pm, Christoph Hellwig wrote:
> On Tue, Jun 11, 2019 at 04:51:02PM +1000, Greg Ungerer wrote:
>> Hi Christoph,
>>
>> On 11/6/19 7:20 am, Christoph Hellwig wrote:
>>> below is a larger stash of cleanups for the binfmt_misc code,
>>> preparing for the last patch that now trivially adds RISC-V
>>> support, which will be used for the RISC-V nommu series I am
>>> about to post.
>>
>> Whole series looks pretty good. Just the one comment I made.
>>
>> I normally take these through the m68knommu git tree,
>> if you have no problem with that I'll push it in there.
>> It will hit linux-next from there.
> 
> Yes, that's fine.  We'll need it to bring up riscv nommu support,
> but there is no actual dependency on the patches for it to compile,
> just for it to actually be useful.
> 
> Btw, it seems like the uclinux-dev list is dead, is there a replacement
> for it?

No, unfortunately no replacement. Generally I think anything that comes
up goes to the architecture list that issues come up on. Probably not
ideal, especially for things like this that are across all arches.

Regards
Greg

