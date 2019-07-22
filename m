Return-Path: <SRS0=CEgE=VT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00D80C76188
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 15:29:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D4874214C6
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 15:29:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729086AbfGVP3N (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jul 2019 11:29:13 -0400
Received: from mga07.intel.com ([134.134.136.100]:36808 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728385AbfGVP3N (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jul 2019 11:29:13 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 22 Jul 2019 08:19:54 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,295,1559545200"; 
   d="scan'208";a="177015340"
Received: from agalla-mobl1.amr.corp.intel.com (HELO [10.254.103.46]) ([10.254.103.46])
  by FMSMGA003.fm.intel.com with ESMTP; 22 Jul 2019 08:19:53 -0700
Subject: Re: [alsa-devel] [PATCH] ASoC: SOF: use __u32 instead of uint32_t in
 uapi headers
To:     Arnd Bergmann <arnd@arndb.de>,
        Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     ALSA Development Mailing List <alsa-devel@alsa-project.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Takashi Iwai <tiwai@suse.com>,
        Liam Girdwood <liam.r.girdwood@linux.intel.com>,
        Mark Brown <broonie@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20190721142308.30306-1-yamada.masahiro@socionext.com>
 <CAK8P3a01MzCTJnk_fuMgWsRBa3u_CEZegZqH37G7qLiquHWncA@mail.gmail.com>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <fdd24e93-efad-0132-e1ff-b7f5f87e8efc@linux.intel.com>
Date:   Mon, 22 Jul 2019 10:19:53 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <CAK8P3a01MzCTJnk_fuMgWsRBa3u_CEZegZqH37G7qLiquHWncA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/22/19 8:39 AM, Arnd Bergmann wrote:
> On Sun, Jul 21, 2019 at 4:25 PM Masahiro Yamada
> <yamada.masahiro@socionext.com> wrote:
>>
>>   struct snd_sof_blk_hdr {
>>          enum snd_sof_fw_blk_type type;
>> -       uint32_t size;          /* bytes minus this header */
>> -       uint32_t offset;        /* offset from base */
>> +       __u32 size;             /* bytes minus this header */
>> +       __u32 offset;           /* offset from base */
>>   } __packed;
>>
> 
> On a related note: Using an 'enum' in an ABI structure is not portable
> across architectures. This is probably fine in a UAPI as long as user
> and kernel space agree on the size of an enum, but if the same
> structure is used to talk to the firmware, it won't work on architectures
> that have a different size for the first field.

yes, we've removed all enums in SOF and missed this one. This should be 
changed, thanks for the note.
