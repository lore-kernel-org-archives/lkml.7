Return-Path: <SRS0=4ODY=VF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C564EC606C1
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 16:44:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A6D5216C4
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 16:44:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jRRfjg/Q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391568AbfGHQoK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jul 2019 12:44:10 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:35390 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729501AbfGHQoJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jul 2019 12:44:09 -0400
Received: by mail-io1-f68.google.com with SMTP id m24so27275633ioo.2
        for <linux-kernel@vger.kernel.org>; Mon, 08 Jul 2019 09:44:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kDPLda0ivm9arT2x6QHrAfqDVAbxojAyd/YYcBxXDpE=;
        b=jRRfjg/QZx3gKH/NwrSHmkOsS+2aLsPrHrPZ9t3iJJM8A2c/oWZIW9OZfXETAFWpqu
         nNDNudd+T91xZA0sFeIml34SAEYqRqaZdnU4vO7C0VogGypxA4KB96/gT+eZLgjacQ13
         Sgpz9fKrGro0er8qnRBlQ5YmwxRn+SEE0IYoCT6FtXQRNZ7EYhTUyoMJBUPkej9XuXvG
         fgglpZ+OLIHYoiTwH1cV+fNMKMUAxp9u1o2FDWmxB4+vkc+0VZJiPfcx/XBjRu6Ppd86
         KPpWtUPeNibsWbdOv5csM4BvL+ORi9pIiq4Butavd7FdIQoFwe1HuEKCAYzgNOY9HhrV
         18+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kDPLda0ivm9arT2x6QHrAfqDVAbxojAyd/YYcBxXDpE=;
        b=Big3fyYJLhyRVAiohhKc1X+x68Gf2fApG57IJo6LuQeKi4xXLvdCeU+ap9zkthfOzc
         sDakqi9knpf6DHMk03iYIOF8Q8i94q4A6kYKEVVJNB5VJ+CB+4+S8mppfV1gP7GqzkAF
         nYaVV4FWpYMMWPCyG+WZYu26sOcUGRFlqCKPLjJ89FeqEgTNQdO5i1SlsH/IAMOQiXnd
         Easf+s3lSQowwTaUXARhMAIcyPbI45AkkewEM9JIEX/F477nlJKkVIbsVNwW5Ux8KqyB
         ELJ/wNSuMACmjA4r7Ykeeup7jlrHkyqjTyX8ODDR7Bw+pjSVhc1Qhe6kxYvKsdYvtasy
         FFug==
X-Gm-Message-State: APjAAAX7r62th9o9YUzfnutGZFzoImuNZZ3N01CRtjl8CRTzPbIwiPRa
        HFIpCK4y7ES+q3sXCPH8VQewXlETe92MY3HiJRTRxg==
X-Google-Smtp-Source: APXvYqznktJ1YU2+JOhhSt4vqEXmVJhsKKZ44A4sGOjDtoY/awZa/+32aRG6KNSM4qgMPyxLIvh+3t+3yBoDZCNJOVo=
X-Received: by 2002:a5d:9dc7:: with SMTP id 7mr20464035ioo.237.1562604248128;
 Mon, 08 Jul 2019 09:44:08 -0700 (PDT)
MIME-Version: 1.0
References: <20190705204512.15444-1-tranmanphong@gmail.com>
In-Reply-To: <20190705204512.15444-1-tranmanphong@gmail.com>
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
Date:   Mon, 8 Jul 2019 10:43:56 -0600
Message-ID: <CANLsYkzTk9a0ToPwMOv5cC8OUA1EvxitbB_rauXhkS4WFz7CWA@mail.gmail.com>
Subject: Re: [PATCH] Documentation: coresight: covert txt to rst
To:     Phong Tran <tranmanphong@gmail.com>
Cc:     Jon Corbet <corbet@lwn.net>,
        "Suzuki K. Poulose" <suzuki.poulose@arm.com>,
        skhan@linuxfoundation.org, mchehab@kernel.org,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-kernel-mentees@lists.linuxfoundation.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tran,

Thank you for doing this - it adds much needed consistency to this
file.  A few of comments below....

On Fri, 5 Jul 2019 at 14:45, Phong Tran <tranmanphong@gmail.com> wrote:
>
> change the format file and adpate the text style

This changtelog is a little short and mentions what you are doing
rather than why.

>
> Signed-off-by: Phong Tran <tranmanphong@gmail.com>
> ---
>  .../trace/{coresight.txt => coresight.rst}         | 296 ++++++++++++---------
>  Documentation/trace/index.rst                      |   1 +
>  2 files changed, 167 insertions(+), 130 deletions(-)
>  rename Documentation/trace/{coresight.txt => coresight.rst} (59%)

File "coresight.txt" is referenced in the MAINTAINERS file and should
probably be changed there as well.

Did you look at coresight-cpu-debug.txt?  In my opinion both files
should be changed in the same patchset.

Thanks,
Mathieu

>
> diff --git a/Documentation/trace/coresight.txt b/Documentation/trace/coresight.rst
> similarity index 59%
> rename from Documentation/trace/coresight.txt
> rename to Documentation/trace/coresight.rst
> index efbc832146e7..bea24e70cfba 100644
> --- a/Documentation/trace/coresight.txt
> +++ b/Documentation/trace/coresight.rst
> @@ -1,5 +1,6 @@
> -               Coresight - HW Assisted Tracing on ARM
> -               ======================================
> +======================================
> +Coresight - HW Assisted Tracing on ARM
> +======================================
>
>     Author:   Mathieu Poirier <mathieu.poirier@linaro.org>
>     Date:     September 11th, 2014
> @@ -26,7 +27,7 @@ implementation, either storing the compressed stream in a memory buffer or
>  creating an interface to the outside world where data can be transferred to a
>  host without fear of filling up the onboard coresight memory buffer.
>
> -At typical coresight system would look like this:
> +At typical coresight system would look like this::
>
>    *****************************************************************
>   **************************** AMBA AXI  ****************************===||
> @@ -95,6 +96,7 @@ Acronyms and Classification
>
>  Acronyms:
>
> +======== =============================================================
>  PTM:     Program Trace Macrocell
>  ETM:     Embedded Trace Macrocell
>  STM:     System trace Macrocell
> @@ -104,6 +106,7 @@ TPIU:    Trace Port Interface Unit
>  TMC-ETR: Trace Memory Controller, configured as Embedded Trace Router
>  TMC-ETF: Trace Memory Controller, configured as Embedded Trace FIFO
>  CTI:     Cross Trigger Interface
> +======== =============================================================
>
>  Classification:
>
> @@ -118,7 +121,7 @@ Misc:
>
>
>  Device Tree Bindings
> -----------------------
> +--------------------
>
>  See Documentation/devicetree/bindings/arm/coresight.txt for details.
>
> @@ -133,57 +136,63 @@ The coresight framework provides a central point to represent, configure and
>  manage coresight devices on a platform.  Any coresight compliant device can
>  register with the framework for as long as they use the right APIs:
>
> -struct coresight_device *coresight_register(struct coresight_desc *desc);
> -void coresight_unregister(struct coresight_device *csdev);
> +.. c:function:: struct coresight_device *coresight_register(struct coresight_desc *desc);
> +.. c:function:: void coresight_unregister(struct coresight_device *csdev);
>
> -The registering function is taking a "struct coresight_device *csdev" and
> +The registering function is taking a :code:`struct coresight_device *csdev` and
>  register the device with the core framework.  The unregister function takes
> -a reference to a "struct coresight_device", obtained at registration time.
> +a reference to a :code:`struct coresight_device`, obtained at registration time.
>
>  If everything goes well during the registration process the new devices will
>  show up under /sys/bus/coresight/devices, as showns here for a TC2 platform:
>
> -root:~# ls /sys/bus/coresight/devices/
> -replicator  20030000.tpiu    2201c000.ptm  2203c000.etm  2203e000.etm
> -20010000.etb         20040000.funnel  2201d000.ptm  2203d000.etm
> -root:~#
> +.. code:: console
>
> -The functions take a "struct coresight_device", which looks like this:
> +    root:~# ls /sys/bus/coresight/devices/
> +    replicator  20030000.tpiu    2201c000.ptm  2203c000.etm  2203e000.etm
> +    20010000.etb         20040000.funnel  2201d000.ptm  2203d000.etm
> +    root:~#
>
> -struct coresight_desc {
> -        enum coresight_dev_type type;
> -        struct coresight_dev_subtype subtype;
> -        const struct coresight_ops *ops;
> -        struct coresight_platform_data *pdata;
> -        struct device *dev;
> -        const struct attribute_group **groups;
> -};
> +The functions take a :code:`struct coresight_device`, which looks like this:
> +
> +.. code:: c
> +
> +    struct coresight_desc {
> +            enum coresight_dev_type type;
> +            struct coresight_dev_subtype subtype;
> +            const struct coresight_ops *ops;
> +            struct coresight_platform_data *pdata;
> +            struct device *dev;
> +            const struct attribute_group **groups;
> +    };
>
>
>  The "coresight_dev_type" identifies what the device is, i.e, source link or
>  sink while the "coresight_dev_subtype" will characterise that type further.
>
> -The "struct coresight_ops" is mandatory and will tell the framework how to
> +The :code:`struct coresight_ops` is mandatory and will tell the framework how to
>  perform base operations related to the components, each component having
> -a different set of requirement.  For that "struct coresight_ops_sink",
> -"struct coresight_ops_link" and "struct coresight_ops_source" have been
> +a different set of requirement.  For that :code:`struct coresight_ops_sink,
> +struct coresight_ops_link` and :code:`struct coresight_ops_source` have been
>  provided.
>
> -The next field, "struct coresight_platform_data *pdata" is acquired by calling
> -"of_get_coresight_platform_data()", as part of the driver's _probe routine and
> -"struct device *dev" gets the device reference embedded in the "amba_device":
> +The next field, :code:`struct coresight_platform_data *pdata` is acquired by calling
> +:code:`of_get_coresight_platform_data()`, as part of the driver's _probe routine and
> +:code:`struct device *dev` gets the device reference embedded in the :code:`amba_device`:
>
> -static int etm_probe(struct amba_device *adev, const struct amba_id *id)
> -{
> - ...
> - ...
> - drvdata->dev = &adev->dev;
> - ...
> -}
> +.. code:: c
> +
> +    static int etm_probe(struct amba_device *adev, const struct amba_id *id)
> +    {
> +     ...
> +     ...
> +     drvdata->dev = &adev->dev;
> +     ...
> +    }
>
>  Specific class of device (source, link, or sink) have generic operations
> -that can be performed on them (see "struct coresight_ops").  The
> -"**groups" is a list of sysfs entries pertaining to operations
> +that can be performed on them (see :code:`struct coresight_ops`).  The
> +:code:`**groups` is a list of sysfs entries pertaining to operations
>  specific to that component only.  "Implementation defined" customisations are
>  expected to be accessed and controlled using those entries.
>
> @@ -204,49 +213,56 @@ There is no limit on the amount of sinks (nor sources) that can be enabled at
>  any given moment.  As a generic operation, all device pertaining to the sink
>  class will have an "active" entry in sysfs:
>
> -root:/sys/bus/coresight/devices# ls
> -replicator  20030000.tpiu    2201c000.ptm  2203c000.etm  2203e000.etm
> -20010000.etb         20040000.funnel  2201d000.ptm  2203d000.etm
> -root:/sys/bus/coresight/devices# ls 20010000.etb
> -enable_sink  status  trigger_cntr
> -root:/sys/bus/coresight/devices# echo 1 > 20010000.etb/enable_sink
> -root:/sys/bus/coresight/devices# cat 20010000.etb/enable_sink
> -1
> -root:/sys/bus/coresight/devices#
> +.. code:: console
> +
> +    root:/sys/bus/coresight/devices# ls
> +    replicator  20030000.tpiu    2201c000.ptm  2203c000.etm  2203e000.etm
> +    20010000.etb         20040000.funnel  2201d000.ptm  2203d000.etm
> +    root:/sys/bus/coresight/devices# ls 20010000.etb
> +    enable_sink  status  trigger_cntr
> +    root:/sys/bus/coresight/devices# echo 1 > 20010000.etb/enable_sink
> +    root:/sys/bus/coresight/devices# cat 20010000.etb/enable_sink
> +    1
> +    root:/sys/bus/coresight/devices#
>
>  At boot time the current etm3x driver will configure the first address
>  comparator with "_stext" and "_etext", essentially tracing any instruction
>  that falls within that range.  As such "enabling" a source will immediately
>  trigger a trace capture:
>
> -root:/sys/bus/coresight/devices# echo 1 > 2201c000.ptm/enable_source
> -root:/sys/bus/coresight/devices# cat 2201c000.ptm/enable_source
> -1
> -root:/sys/bus/coresight/devices# cat 20010000.etb/status
> -Depth:          0x2000
> -Status:         0x1
> -RAM read ptr:   0x0
> -RAM wrt ptr:    0x19d3   <----- The write pointer is moving
> -Trigger cnt:    0x0
> -Control:        0x1
> -Flush status:   0x0
> -Flush ctrl:     0x2001
> -root:/sys/bus/coresight/devices#
> +.. code:: console
> +
> +    root:/sys/bus/coresight/devices# echo 1 > 2201c000.ptm/enable_source
> +    root:/sys/bus/coresight/devices# cat 2201c000.ptm/enable_source
> +    1
> +    root:/sys/bus/coresight/devices# cat 20010000.etb/status
> +    Depth:          0x2000
> +    Status:         0x1
> +    RAM read ptr:   0x0
> +    RAM wrt ptr:    0x19d3   <----- The write pointer is moving
> +    Trigger cnt:    0x0
> +    Control:        0x1
> +    Flush status:   0x0
> +    Flush ctrl:     0x2001
> +    root:/sys/bus/coresight/devices#
>
>  Trace collection is stopped the same way:
>
> -root:/sys/bus/coresight/devices# echo 0 > 2201c000.ptm/enable_source
> -root:/sys/bus/coresight/devices#
> +.. code:: console
> +
> +    root:/sys/bus/coresight/devices# echo 0 > 2201c000.ptm/enable_source
> +    root:/sys/bus/coresight/devices#
>
>  The content of the ETB buffer can be harvested directly from /dev:
>
> -root:/sys/bus/coresight/devices# dd if=/dev/20010000.etb \
> -of=~/cstrace.bin
> +.. code:: console
>
> -64+0 records in
> -64+0 records out
> -32768 bytes (33 kB) copied, 0.00125258 s, 26.2 MB/s
> -root:/sys/bus/coresight/devices#
> +    root:/sys/bus/coresight/devices# dd if=/dev/20010000.etb \
> +    of=~/cstrace.bin
> +    64+0 records in
> +    64+0 records out
> +    32768 bytes (33 kB) copied, 0.00125258 s, 26.2 MB/s
> +    root:/sys/bus/coresight/devices#
>
>  The file cstrace.bin can be decompressed using "ptm2human", DS-5 or Trace32.
>
> @@ -254,55 +270,57 @@ Following is a DS-5 output of an experimental loop that increments a variable up
>  to a certain value.  The example is simple and yet provides a glimpse of the
>  wealth of possibilities that coresight provides.
>
> -Info                                    Tracing enabled
> -Instruction     106378866       0x8026B53C      E52DE004        false   PUSH     {lr}
> -Instruction     0       0x8026B540      E24DD00C        false   SUB      sp,sp,#0xc
> -Instruction     0       0x8026B544      E3A03000        false   MOV      r3,#0
> -Instruction     0       0x8026B548      E58D3004        false   STR      r3,[sp,#4]
> -Instruction     0       0x8026B54C      E59D3004        false   LDR      r3,[sp,#4]
> -Instruction     0       0x8026B550      E3530004        false   CMP      r3,#4
> -Instruction     0       0x8026B554      E2833001        false   ADD      r3,r3,#1
> -Instruction     0       0x8026B558      E58D3004        false   STR      r3,[sp,#4]
> -Instruction     0       0x8026B55C      DAFFFFFA        true    BLE      {pc}-0x10 ; 0x8026b54c
> -Timestamp                                       Timestamp: 17106715833
> -Instruction     319     0x8026B54C      E59D3004        false   LDR      r3,[sp,#4]
> -Instruction     0       0x8026B550      E3530004        false   CMP      r3,#4
> -Instruction     0       0x8026B554      E2833001        false   ADD      r3,r3,#1
> -Instruction     0       0x8026B558      E58D3004        false   STR      r3,[sp,#4]
> -Instruction     0       0x8026B55C      DAFFFFFA        true    BLE      {pc}-0x10 ; 0x8026b54c
> -Instruction     9       0x8026B54C      E59D3004        false   LDR      r3,[sp,#4]
> -Instruction     0       0x8026B550      E3530004        false   CMP      r3,#4
> -Instruction     0       0x8026B554      E2833001        false   ADD      r3,r3,#1
> -Instruction     0       0x8026B558      E58D3004        false   STR      r3,[sp,#4]
> -Instruction     0       0x8026B55C      DAFFFFFA        true    BLE      {pc}-0x10 ; 0x8026b54c
> -Instruction     7       0x8026B54C      E59D3004        false   LDR      r3,[sp,#4]
> -Instruction     0       0x8026B550      E3530004        false   CMP      r3,#4
> -Instruction     0       0x8026B554      E2833001        false   ADD      r3,r3,#1
> -Instruction     0       0x8026B558      E58D3004        false   STR      r3,[sp,#4]
> -Instruction     0       0x8026B55C      DAFFFFFA        true    BLE      {pc}-0x10 ; 0x8026b54c
> -Instruction     7       0x8026B54C      E59D3004        false   LDR      r3,[sp,#4]
> -Instruction     0       0x8026B550      E3530004        false   CMP      r3,#4
> -Instruction     0       0x8026B554      E2833001        false   ADD      r3,r3,#1
> -Instruction     0       0x8026B558      E58D3004        false   STR      r3,[sp,#4]
> -Instruction     0       0x8026B55C      DAFFFFFA        true    BLE      {pc}-0x10 ; 0x8026b54c
> -Instruction     10      0x8026B54C      E59D3004        false   LDR      r3,[sp,#4]
> -Instruction     0       0x8026B550      E3530004        false   CMP      r3,#4
> -Instruction     0       0x8026B554      E2833001        false   ADD      r3,r3,#1
> -Instruction     0       0x8026B558      E58D3004        false   STR      r3,[sp,#4]
> -Instruction     0       0x8026B55C      DAFFFFFA        true    BLE      {pc}-0x10 ; 0x8026b54c
> -Instruction     6       0x8026B560      EE1D3F30        false   MRC      p15,#0x0,r3,c13,c0,#1
> -Instruction     0       0x8026B564      E1A0100D        false   MOV      r1,sp
> -Instruction     0       0x8026B568      E3C12D7F        false   BIC      r2,r1,#0x1fc0
> -Instruction     0       0x8026B56C      E3C2203F        false   BIC      r2,r2,#0x3f
> -Instruction     0       0x8026B570      E59D1004        false   LDR      r1,[sp,#4]
> -Instruction     0       0x8026B574      E59F0010        false   LDR      r0,[pc,#16] ; [0x8026B58C] = 0x80550368
> -Instruction     0       0x8026B578      E592200C        false   LDR      r2,[r2,#0xc]
> -Instruction     0       0x8026B57C      E59221D0        false   LDR      r2,[r2,#0x1d0]
> -Instruction     0       0x8026B580      EB07A4CF        true    BL       {pc}+0x1e9344 ; 0x804548c4
> -Info                                    Tracing enabled
> -Instruction     13570831        0x8026B584      E28DD00C        false   ADD      sp,sp,#0xc
> -Instruction     0       0x8026B588      E8BD8000        true    LDM      sp!,{pc}
> -Timestamp                                       Timestamp: 17107041535
> +.. code:: c
> +
> +    Info                                    Tracing enabled
> +    Instruction     106378866       0x8026B53C      E52DE004        false   PUSH     {lr}
> +    Instruction     0       0x8026B540      E24DD00C        false   SUB      sp,sp,#0xc
> +    Instruction     0       0x8026B544      E3A03000        false   MOV      r3,#0
> +    Instruction     0       0x8026B548      E58D3004        false   STR      r3,[sp,#4]
> +    Instruction     0       0x8026B54C      E59D3004        false   LDR      r3,[sp,#4]
> +    Instruction     0       0x8026B550      E3530004        false   CMP      r3,#4
> +    Instruction     0       0x8026B554      E2833001        false   ADD      r3,r3,#1
> +    Instruction     0       0x8026B558      E58D3004        false   STR      r3,[sp,#4]
> +    Instruction     0       0x8026B55C      DAFFFFFA        true    BLE      {pc}-0x10 ; 0x8026b54c
> +    Timestamp                                       Timestamp: 17106715833
> +    Instruction     319     0x8026B54C      E59D3004        false   LDR      r3,[sp,#4]
> +    Instruction     0       0x8026B550      E3530004        false   CMP      r3,#4
> +    Instruction     0       0x8026B554      E2833001        false   ADD      r3,r3,#1
> +    Instruction     0       0x8026B558      E58D3004        false   STR      r3,[sp,#4]
> +    Instruction     0       0x8026B55C      DAFFFFFA        true    BLE      {pc}-0x10 ; 0x8026b54c
> +    Instruction     9       0x8026B54C      E59D3004        false   LDR      r3,[sp,#4]
> +    Instruction     0       0x8026B550      E3530004        false   CMP      r3,#4
> +    Instruction     0       0x8026B554      E2833001        false   ADD      r3,r3,#1
> +    Instruction     0       0x8026B558      E58D3004        false   STR      r3,[sp,#4]
> +    Instruction     0       0x8026B55C      DAFFFFFA        true    BLE      {pc}-0x10 ; 0x8026b54c
> +    Instruction     7       0x8026B54C      E59D3004        false   LDR      r3,[sp,#4]
> +    Instruction     0       0x8026B550      E3530004        false   CMP      r3,#4
> +    Instruction     0       0x8026B554      E2833001        false   ADD      r3,r3,#1
> +    Instruction     0       0x8026B558      E58D3004        false   STR      r3,[sp,#4]
> +    Instruction     0       0x8026B55C      DAFFFFFA        true    BLE      {pc}-0x10 ; 0x8026b54c
> +    Instruction     7       0x8026B54C      E59D3004        false   LDR      r3,[sp,#4]
> +    Instruction     0       0x8026B550      E3530004        false   CMP      r3,#4
> +    Instruction     0       0x8026B554      E2833001        false   ADD      r3,r3,#1
> +    Instruction     0       0x8026B558      E58D3004        false   STR      r3,[sp,#4]
> +    Instruction     0       0x8026B55C      DAFFFFFA        true    BLE      {pc}-0x10 ; 0x8026b54c
> +    Instruction     10      0x8026B54C      E59D3004        false   LDR      r3,[sp,#4]
> +    Instruction     0       0x8026B550      E3530004        false   CMP      r3,#4
> +    Instruction     0       0x8026B554      E2833001        false   ADD      r3,r3,#1
> +    Instruction     0       0x8026B558      E58D3004        false   STR      r3,[sp,#4]
> +    Instruction     0       0x8026B55C      DAFFFFFA        true    BLE      {pc}-0x10 ; 0x8026b54c
> +    Instruction     6       0x8026B560      EE1D3F30        false   MRC      p15,#0x0,r3,c13,c0,#1
> +    Instruction     0       0x8026B564      E1A0100D        false   MOV      r1,sp
> +    Instruction     0       0x8026B568      E3C12D7F        false   BIC      r2,r1,#0x1fc0
> +    Instruction     0       0x8026B56C      E3C2203F        false   BIC      r2,r2,#0x3f
> +    Instruction     0       0x8026B570      E59D1004        false   LDR      r1,[sp,#4]
> +    Instruction     0       0x8026B574      E59F0010        false   LDR      r0,[pc,#16] ; [0x8026B58C] = 0x80550368
> +    Instruction     0       0x8026B578      E592200C        false   LDR      r2,[r2,#0xc]
> +    Instruction     0       0x8026B57C      E59221D0        false   LDR      r2,[r2,#0x1d0]
> +    Instruction     0       0x8026B580      EB07A4CF        true    BL       {pc}+0x1e9344 ; 0x804548c4
> +    Info                                    Tracing enabled
> +    Instruction     13570831        0x8026B584      E28DD00C        false   ADD      sp,sp,#0xc
> +    Instruction     0       0x8026B588      E8BD8000        true    LDM      sp!,{pc}
> +    Timestamp                                       Timestamp: 17107041535
>
>  2) Using perf framework:
>
> @@ -312,6 +330,8 @@ controlling when tracing gets enabled based on when the process of interest is
>  scheduled.  When configured in a system, Coresight PMUs will be listed when
>  queried by the perf command line tool:
>
> +.. code:: console
> +
>         linaro@linaro-nano:~$ ./perf list pmu
>
>                 List of pre-defined events (to be used in -e):
> @@ -329,6 +349,8 @@ Coresight system will typically have more than one sink, the name of the sink to
>  work with needs to be specified as an event option.  Names for sink to choose
>  from are listed in sysFS under ($SYSFS)/bus/coresight/devices:
>
> +.. code:: console
> +
>         root@linaro-nano:~# ls /sys/bus/coresight/devices/
>                 20010000.etf   20040000.funnel  20100000.stm  22040000.etm
>                 22140000.etm  230c0000.funnel  23240000.etm 20030000.tpiu
> @@ -343,7 +365,7 @@ to use for the trace session.
>
>  More information on the above and other example on how to use Coresight with
>  the perf tools can be found in the "HOWTO.md" file of the openCSD gitHub
> -repository [3].
> +repository [#third]_.
>
>  2.1) AutoFDO analysis using the perf tools:
>
> @@ -352,6 +374,8 @@ perf can be used to record and analyze trace of programs.
>  Execution can be recorded using 'perf record' with the cs_etm event,
>  specifying the name of the sink to record to, e.g:
>
> +.. code:: console
> +
>      perf record -e cs_etm/@20070000.etr/u --per-thread
>
>  The 'perf report' and 'perf script' commands can be used to analyze execution,
> @@ -370,12 +394,16 @@ Generating coverage files for Feedback Directed Optimization: AutoFDO
>  'perf inject' accepts the --itrace option in which case tracing data is
>  removed and replaced with the synthesized events. e.g.
>
> +.. code:: console
> +
>         perf inject --itrace --strip -i perf.data -o perf.data.new
>
>  Below is an example of using ARM ETM for autoFDO.  It requires autofdo
>  (https://github.com/google/autofdo) and gcc version 5.  The bubble
>  sort example is from the AutoFDO tutorial (https://gcc.gnu.org/wiki/AutoFDO/Tutorial).
>
> +.. code:: console
> +
>         $ gcc-5 -O3 sort.c -o sort
>         $ taskset -c 2 ./sort
>         Bubble sorting array of 30000 elements
> @@ -403,28 +431,36 @@ difference is that clients are driving the trace capture rather
>  than the program flow through the code.
>
>  As with any other CoreSight component, specifics about the STM tracer can be
> -found in sysfs with more information on each entry being found in [1]:
> +found in sysfs with more information on each entry being found in [#first]_:
>
> -root@genericarmv8:~# ls /sys/bus/coresight/devices/20100000.stm
> -enable_source   hwevent_select  port_enable     subsystem       uevent
> -hwevent_enable  mgmt            port_select     traceid
> -root@genericarmv8:~#
> +.. code:: console
> +
> +    root@genericarmv8:~# ls /sys/bus/coresight/devices/20100000.stm
> +    enable_source   hwevent_select  port_enable     subsystem       uevent
> +    hwevent_enable  mgmt            port_select     traceid
> +    root@genericarmv8:~#
>
>  Like any other source a sink needs to be identified and the STM enabled before
>  being used:
>
> -root@genericarmv8:~# echo 1 > /sys/bus/coresight/devices/20010000.etf/enable_sink
> -root@genericarmv8:~# echo 1 > /sys/bus/coresight/devices/20100000.stm/enable_source
> +.. code:: console
> +
> +    root@genericarmv8:~# echo 1 > /sys/bus/coresight/devices/20010000.etf/enable_sink
> +    root@genericarmv8:~# echo 1 > /sys/bus/coresight/devices/20100000.stm/enable_source
>
>  From there user space applications can request and use channels using the devfs
>  interface provided for that purpose by the generic STM API:
>
> -root@genericarmv8:~# ls -l /dev/20100000.stm
> -crw-------    1 root     root       10,  61 Jan  3 18:11 /dev/20100000.stm
> -root@genericarmv8:~#
> +.. code:: console
> +
> +    root@genericarmv8:~# ls -l /dev/20100000.stm
> +    crw-------    1 root     root       10,  61 Jan  3 18:11 /dev/20100000.stm
> +    root@genericarmv8:~#
> +
> +Details on how to use the generic STM API can be found here [#second]_.
> +
> +.. [#first] Documentation/ABI/testing/sysfs-bus-coresight-devices-stm
>
> -Details on how to use the generic STM API can be found here [2].
> +.. [#second] Documentation/trace/stm.rst
>
> -[1]. Documentation/ABI/testing/sysfs-bus-coresight-devices-stm
> -[2]. Documentation/trace/stm.rst
> -[3]. https://github.com/Linaro/perf-opencsd
> +.. [#third] https://github.com/Linaro/perf-opencsd
> diff --git a/Documentation/trace/index.rst b/Documentation/trace/index.rst
> index 6b4107cf4b98..3330c5456bcb 100644
> --- a/Documentation/trace/index.rst
> +++ b/Documentation/trace/index.rst
> @@ -23,3 +23,4 @@ Linux Tracing Technologies
>     intel_th
>     stm
>     sys-t
> +   coresight
> --
> 2.11.0
>
