Return-Path: <SRS0=CEgE=VT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE5C0C76190
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 15:22:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D503204FD
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 15:22:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728768AbfGVPWH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jul 2019 11:22:07 -0400
Received: from mga18.intel.com ([134.134.136.126]:32148 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728288AbfGVPWG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jul 2019 11:22:06 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 22 Jul 2019 08:18:27 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,295,1559545200"; 
   d="scan'208";a="177014956"
Received: from agalla-mobl1.amr.corp.intel.com (HELO [10.254.103.46]) ([10.254.103.46])
  by FMSMGA003.fm.intel.com with ESMTP; 22 Jul 2019 08:18:25 -0700
Subject: Re: [alsa-devel] [PATCH] ASoC: SOF: use __u32 instead of uint32_t in
 uapi headers
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Takashi Iwai <tiwai@suse.de>,
        ALSA Development Mailing List <alsa-devel@alsa-project.org>,
        Mark Brown <broonie@kernel.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Liam Girdwood <liam.r.girdwood@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20190721142308.30306-1-yamada.masahiro@socionext.com>
 <de9e94ee-9c01-1c0c-4359-b637319a298f@linux.intel.com>
 <s5hftmy8byl.wl-tiwai@suse.de>
 <ec306745-052d-f52c-2cce-d8915822d4ff@linux.intel.com>
 <CAK8P3a2tLuqu+upt0nW8dUzXc+t_kEJwVhLcqY8TXydHLb_nCw@mail.gmail.com>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <9a56ccdb-397b-3046-4043-49bc20aaa804@linux.intel.com>
Date:   Mon, 22 Jul 2019 10:18:25 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <CAK8P3a2tLuqu+upt0nW8dUzXc+t_kEJwVhLcqY8TXydHLb_nCw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/22/19 8:34 AM, Arnd Bergmann wrote:
> On Mon, Jul 22, 2019 at 3:16 PM Pierre-Louis Bossart
> <pierre-louis.bossart@linux.intel.com> wrote:
>> On 7/22/19 7:56 AM, Takashi Iwai wrote:
>>> On Mon, 22 Jul 2019 14:49:34 +0200,
>>> Pierre-Louis Bossart wrote:
>>>>
>>>>
>>>>
>>>> On 7/21/19 9:23 AM, Masahiro Yamada wrote:
>>>>> When CONFIG_UAPI_HEADER_TEST=y, exported headers are compile-tested to
>>>>> make sure they can be included from user-space.
>>>>>
>>>>> Currently, header.h and fw.h are excluded from the test coverage.
>>>>> To make them join the compile-test, we need to fix the build errors
>>>>> attached below.
>>>>>
>>>>> For a case like this, we decided to use __u{8,16,32,64} variable types
>>>>> in this discussion:
>>>>>
>>>>>      https://lkml.org/lkml/2019/6/5/18
>>>>
>>>> these files are shared with the SOF project and used as is (with minor
>>>> formatting) for the firmware compilation. I am not sure I understand
>>>> the ask here, are you really asking SOF to use linux-specific type
>>>> definitions?
>>>
>>> Actually this is linux-kernel UAPI header files, so yes, we should
>>> follow the convention there as much as possible.
>>>
>>> So far we haven't been strict about these types.  But now we have a
>>> unit test for checking it, so it's a good opportunity to address the
>>> issues.
>>
>> Maybe a bit of background. For SOF we split the includes in 4 directories
>>
>> https://github.com/thesofproject/sof/tree/master/src/include
>>
>> - sof: internal includes for firmware only
>> - ipc: definitions of the structures for information exchanged over the
>> IPC channel. This directory is used as is by the Linux kernel and
>> mirrored in include/sound/sof
>> - user: definitions needed for firmware tools, e.g. to generate the
>> image or parse the trace. this directory is not used by the Linux kernel.
>> - kernel: definitions for the firmware format, needed for the loader to
>> parse the firmware files. This is not directly used by applications
>> running on the target, it really defines the content passed to the
>> kernel with request_firmware. This directory is mirrored in the Linux
>> include/uapi/sound/sof directory.
>>
>> Our goal is to minimize the differences and allow deltas e.g. for
>> license or comments. We could add a definition for __u32 when linux is
>> not used, I am just not sure if these two files really fall in the UAPI
>> category and if the checks make sense.
> 
> If you can build all the SOF user space without these headers being
> installed to /usr/include/sound/sof/, you can move them from
> include/uapi/sound/sof to include/sounds/sof and leave the types
> unchanged.

yes we don't need those files to build userspace stuff. The idea was 
that these format definitions establish a contract between userspace 
(more specifically the files stored in /lib/firmware) and the kernel. 
IIRC we wanted to make sure that any changes would be tracked as 
breaking userspace. If the consensus is that the uapi directory is 
strictly used for builds then we should indeed move those files
