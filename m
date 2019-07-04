Return-Path: <SRS0=IBEs=VB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AA22C0651F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jul 2019 14:32:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1BD58218A3
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jul 2019 14:32:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XA9XKA4y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727760AbfGDOc3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Jul 2019 10:32:29 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:34038 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727246AbfGDOc2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Jul 2019 10:32:28 -0400
Received: by mail-ed1-f66.google.com with SMTP id s49so5643016edb.1;
        Thu, 04 Jul 2019 07:32:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=hG94lb2mfNpipyjyuBXQyz3ZoROecI4LdyTS4Vj1aUM=;
        b=XA9XKA4yi6IQLxDBOZSLzJDJ1P24RGWiALToGJfWjOvu6I+Lke7v4PE6vpt4zTO45f
         KiGPVmx1c1YtAzr2WZyJp0525y0uUiM0nG9LLRg6mxDNCw6Xjp57vDWhre5xVltjNySp
         f8Kfe+ewF1z6ILjMGeW6+dSFXbKC6OMpbRdbLLXxVMTBh5vM6N1C3hDZs5renLsWJYFu
         9ZITRK7Bq4lRDxMwAHxLE18gAr8rESKdd5uHipVnCKM2I/iaZ66fShyrSwZuIKR2f0G4
         eoPyMPB/TzopgZTTNzImjgnkfQ6OHld219zrdZGZLVZ0mATlt7Ix7UlE54yZgAgYouJV
         SU+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=hG94lb2mfNpipyjyuBXQyz3ZoROecI4LdyTS4Vj1aUM=;
        b=B9yyrZbSuQ1ZVpOKBvXQCNTuG0TCNtLR6ykh7Hyx/EdwPc9E5rwbyEF8SrxWvWfS92
         G8hNWhJITHoSvhnwMgR/hQOnotAgQCaSxVv8ViVpOsIXunj4Kqqwm07flLd8dxM71xeg
         5OMsnQ9JtpJAqIAr9dkR2Xmfa6OwImL2rYYLXm7QlwQ7cKWWYVuy6U69Emv6H3ZkA6BH
         XQ8DCdtTrnPJD6kEmYIgdMBBiG5piHKeMD9Rgt5DcXfxaBRGBUQELw45Nt70FeyrWe+h
         h0/2HMKWYWgUXYFYaflOP9Rsup65E9N0tt8qybYQWvPGN3xe7XwwpPGOR1eHb7qmhAoW
         m5JQ==
X-Gm-Message-State: APjAAAUpS5EqjbE+AXH71UjJZ0uIh6mLZFF1Y/G/19zokNwJRKAt72dY
        sy9BZ+duRdIpxaNw8aqQuFk+GeOu
X-Google-Smtp-Source: APXvYqzT2XlfYr+uxPrC/zJOphkRAdeGPMcKImu0CzVFB9O9lFTTq1YMhHbw65sOeQXrNnJ2ydEjqA==
X-Received: by 2002:a17:906:1f43:: with SMTP id d3mr29380618ejk.169.1562250745941;
        Thu, 04 Jul 2019 07:32:25 -0700 (PDT)
Received: from [10.68.217.182] ([217.70.211.18])
        by smtp.gmail.com with ESMTPSA id x10sm1708831edd.73.2019.07.04.07.32.24
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Thu, 04 Jul 2019 07:32:25 -0700 (PDT)
Subject: Re: [PATCH] dax: Fix missed PMD wakeups
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Dan Williams <dan.j.williams@intel.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Jan Kara <jack@suse.cz>, stable <stable@vger.kernel.org>,
        Robert Barror <robert.barror@intel.com>,
        Seema Pandit <seema.pandit@intel.com>,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <156213869409.3910140.7715747316991468148.stgit@dwillia2-desk3.amr.corp.intel.com>
 <20190703121743.GH1729@bombadil.infradead.org>
 <CAPcyv4jgs5LTtTXR+2CyfbjJE85B_eoPFuXQsGBDnVMo41Jawg@mail.gmail.com>
 <20190703195302.GJ1729@bombadil.infradead.org>
 <CAPcyv4iPNz=oJyc_EoE-mC11=gyBzwMKbmj1ZY_Yna54=cC=Mg@mail.gmail.com>
 <20190704032728.GK1729@bombadil.infradead.org>
 <f23a1c71-d1b1-b279-c922-ce0f48cb4448@gmail.com>
 <20190704135804.GL1729@bombadil.infradead.org>
From:   Boaz Harrosh <openosd@gmail.com>
Message-ID: <bfe7c33d-7c3c-dcc0-5408-e23ea8223ef0@gmail.com>
Date:   Thu, 4 Jul 2019 17:32:23 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190704135804.GL1729@bombadil.infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-MW
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/07/2019 16:58, Matthew Wilcox wrote:
> On Thu, Jul 04, 2019 at 04:00:00PM +0300, Boaz Harrosh wrote:
<>
>> Matthew you must be kidding an ilog2 in binary is zero clocks
>> (Return the highest bit or something like that)
> 
> You might want to actually check the documentation instead of just
> making shit up.
> 

Yes you are right I stand corrected. Must be smoking ;-)

> https://www.agner.org/optimize/instruction_tables.pdf
> 
> I think in this instance what we want is BSR (aka ffz) since the input is
> going to be one of 0, 1, 3, 7, 15 or 31 (and we want 0, 1, 2, 3, 4, 5 as
> results).
> 
<>
> The compiler doesn't know the range of 'sibs'.  Unless we do the
> profile-feedback thing.
> 

Would you please consider the use of get_order() macro from #include <getorder.h>
Just for the sake of understanding? (Or at least a comment)

Thanks
Boaz
