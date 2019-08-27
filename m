Return-Path: <SRS0=qJmF=WX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFBF0C3A5A3
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 12:33:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 836722077B
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 12:33:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729491AbfH0Md2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Aug 2019 08:33:28 -0400
Received: from mga12.intel.com ([192.55.52.136]:2230 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726140AbfH0Md2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Aug 2019 08:33:28 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 27 Aug 2019 05:33:27 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,437,1559545200"; 
   d="scan'208";a="380898380"
Received: from rongch2-mobl.ccr.corp.intel.com (HELO [10.249.171.56]) ([10.249.171.56])
  by fmsmga006.fm.intel.com with ESMTP; 27 Aug 2019 05:33:25 -0700
Subject: Re: [LKP] [drm/mgag200] 90f479ae51: vm-scalability.median -18.8%
 regression
To:     Thomas Zimmermann <tzimmermann@suse.de>,
        Feng Tang <feng.tang@intel.com>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>, michel@daenzer.net,
        linux-kernel@vger.kernel.org,
        dri-devel <dri-devel@lists.freedesktop.org>, lkp@01.org
References: <14fdaaed-51c8-b270-b46b-cba7b5c4ba52@suse.de>
 <20190805070200.GA91650@shbuild999.sh.intel.com>
 <c0c3f387-dc93-3146-788c-23258b28a015@intel.com>
 <045a23ab-78f7-f363-4a2e-bf24a7a2f79e@suse.de>
 <37ae41e4-455d-c18d-5c93-7df854abfef9@intel.com>
 <370747ca-4dc9-917b-096c-891dcc2aedf0@suse.de>
 <c6e220fe-230c-265c-f2fc-b0948d1cb898@intel.com>
 <20190812072545.GA63191@shbuild999.sh.intel.com>
 <20190813093616.GA65475@shbuild999.sh.intel.com>
 <64d41701-55a4-e526-17ae-8936de4bc1ef@suse.de>
 <20190824051605.GA63850@shbuild999.sh.intel.com>
 <1b897bfe-fd40-3ae3-d867-424d1fc08c44@suse.de>
From:   "Chen, Rong A" <rong.a.chen@intel.com>
Message-ID: <d114b0b6-6b64-406e-6c3f-a8b8d5502413@intel.com>
Date:   Tue, 27 Aug 2019 20:33:24 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <1b897bfe-fd40-3ae3-d867-424d1fc08c44@suse.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Thomas,

On 8/26/2019 6:50 PM, Thomas Zimmermann wrote:
> Hi Feng
>
> Am 24.08.19 um 07:16 schrieb Feng Tang:
>> Hi Thomas,
>>
>> On Thu, Aug 22, 2019 at 07:25:11PM +0200, Thomas Zimmermann wrote:
>>> Hi
>>>
>>> I was traveling and could reply earlier. Sorry for taking so long.
>> No problem! I guessed so :)
>>
>>> Am 13.08.19 um 11:36 schrieb Feng Tang:
>>>> Hi Thomas,
>>>>
>>>> On Mon, Aug 12, 2019 at 03:25:45PM +0800, Feng Tang wrote:
>>>>> Hi Thomas,
>>>>>
>>>>> On Fri, Aug 09, 2019 at 04:12:29PM +0800, Rong Chen wrote:
>>>>>> Hi,
>>>>>>
>>>>>>>> Actually we run the benchmark as a background process, do
>>>>>>>> we need to disable the cursor and test again?
>>>>>>> There's a worker thread that updates the display from the
>>>>>>> shadow buffer. The blinking cursor periodically triggers
>>>>>>> the worker thread, but the actual update is just the size
>>>>>>> of one character.
>>>>>>>
>>>>>>> The point of the test without output is to see if the
>>>>>>> regression comes from the buffer update (i.e., the memcpy
>>>>>>> from shadow buffer to VRAM), or from the worker thread. If
>>>>>>>   the regression goes away after disabling the blinking
>>>>>>> cursor, then the worker thread is the problem. If it
>>>>>>> already goes away if there's simply no output from the
>>>>>>> test, the screen update is the problem. On my machine I
>>>>>>> have to disable the blinking cursor, so I think the worker
>>>>>>>   causes the performance drop.
>>>>>> We disabled redirecting stdout/stderr to /dev/kmsg,  and the
>>>>>>   regression is gone.
>>>>>>
>>>>>> commit: f1f8555dfb9 drm/bochs: Use shadow buffer for bochs
>>>>>> framebuffer console 90f479ae51a drm/mgag200: Replace struct
>>>>>> mga_fbdev with generic framebuffer emulation
>>>>>>
>>>>>> f1f8555dfb9a70a2  90f479ae51afa45efab97afdde
>>>>>> testcase/testparams/testbox ----------------
>>>>>> -------------------------- ---------------------------
>>>>>> %stddev      change         %stddev \          | \ 43785
>>>>>> 44481 vm-scalability/300s-8T-anon-cow-seq-hugetlb/lkp-knm01
>>>>>> 43785 44481        GEO-MEAN vm-scalability.median
>>>>> Till now, from Rong's tests: 1. Disabling cursor blinking
>>>>> doesn't cure the regression. 2. Disabling printint test results
>>>>> to console can workaround the regression.
>>>>>
>>>>> Also if we set the perfer_shadown to 0, the regression is also
>>>>> gone.
>>>> We also did some further break down for the time consumed by the
>>>> new code.
>>>>
>>>> The drm_fb_helper_dirty_work() calls sequentially 1.
>>>> drm_client_buffer_vmap	  (290 us) 2.
>>>> drm_fb_helper_dirty_blit_real  (19240 us) 3.
>>>> helper->fb->funcs->dirty()    ---> NULL for mgag200 driver 4.
>>>> drm_client_buffer_vunmap       (215 us)
>>>>
>>> It's somewhat different to what I observed, but maybe I just
>>> couldn't reproduce the problem correctly.
>>>
>>>> The average run time is listed after the function names.
>>>>
>>>>  From it, we can see drm_fb_helper_dirty_blit_real() takes too
>>>> long time (about 20ms for each run). I guess this is the root
>>>> cause of this regression, as the original code doesn't use this
>>>> dirty worker.
>>> True, the original code uses a temporary buffer, but updates the
>>> display immediately.
>>>
>>> My guess is that this could be a caching problem. The worker runs
>>> on a different CPU, which doesn't have the shadow buffer in cache.
>> Yes, that's my thought too. I profiled the working set size, for most
>> of the drm_fb_helper_dirty_blit_real(), it will update a buffer
>> 4096x768(3 MB), and as it is called 30~40 times per second, it surely
>> will affect the cache.
>>
>>
>>>> As said in last email, setting the prefer_shadow to 0 can avoid
>>>> the regrssion. Could it be an option?
>>> Unfortunately not. Without the shadow buffer, the console's
>>> display buffer permanently resides in video memory. It consumes
>>> significant amount of that memory (say 8 MiB out of 16 MiB). That
>>> doesn't leave enough room for anything else.
>>>
>>> The best option is to not print to the console.
>> Do we have other options here?
> I attached two patches. Both show an improvement in my setup at least.
> Could you please test them independently from each other and report back?
>
> prefetch.patch prefetches the shadow buffer two scanlines ahead during
> the blit function. The idea is to have the scanlines in cache when they
> are supposed to go to hardware.
>
> schedule.patch schedules the dirty worker on the current CPU core (i.e.,
> the one that did the drawing to the shadow buffer). Hopefully the shadow
> buffer remains in cache meanwhile.
>
> Best regards
> Thomas

Both patches have little impact on the performance from our side.

prefetch.patch:
commit:
   f1f8555dfb9 drm/bochs: Use shadow buffer for bochs framebuffer console
   90f479ae51a drm/mgag200: Replace struct mga_fbdev with generic 
framebuffer emulation
   77459f56994 prefetch shadow buffer two lines ahead of blit offset

f1f8555dfb9a70a2  90f479ae51afa45efab97afdde 77459f56994ab87ee5459920b3  
testcase/testparams/testbox
----------------  -------------------------- --------------------------  
---------------------------
          %stddev      change         %stddev      change %stddev
              \          |                \          | \
      42912             -15%      36517             -17% 35515 
vm-scalability/performance-300s-8T-anon-cow-seq-hugetlb/lkp-knm01
      42912             -15%      36517             -17% 35515        
GEO-MEAN vm-scalability.median

schedule.patch:
commit:
   f1f8555dfb9 drm/bochs: Use shadow buffer for bochs framebuffer console
   90f479ae51a drm/mgag200: Replace struct mga_fbdev with generic 
framebuffer emulation
   ccc5f095c61 schedule dirty worker on local core

f1f8555dfb9a70a2  90f479ae51afa45efab97afdde ccc5f095c61ff6eded0f0ab1b7  
testcase/testparams/testbox
----------------  -------------------------- --------------------------  
---------------------------
          %stddev      change         %stddev      change %stddev
              \          |                \          | \
      42912             -15%      36517             -15%      36556 ±  
4% vm-scalability/performance-300s-8T-anon-cow-seq-hugetlb/lkp-knm01
      42912             -15%      36517             -15% 36556        
GEO-MEAN vm-scalability.median

Best Regards,
Rong Chen
