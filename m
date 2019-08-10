Return-Path: <SRS0=4CSQ=WG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7FDAC32751
	for <linux-kernel@archiver.kernel.org>; Sat, 10 Aug 2019 11:24:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E8502166E
	for <linux-kernel@archiver.kernel.org>; Sat, 10 Aug 2019 11:24:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j6WHuuNs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726196AbfHJLYQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 10 Aug 2019 07:24:16 -0400
Received: from mail-ot1-f53.google.com ([209.85.210.53]:41418 "EHLO
        mail-ot1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725862AbfHJLYP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Aug 2019 07:24:15 -0400
Received: by mail-ot1-f53.google.com with SMTP id o101so7751073ota.8
        for <linux-kernel@vger.kernel.org>; Sat, 10 Aug 2019 04:24:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=PUIdRGTZnL511IPwlLCU9M17oDUYX9EP4DtFSDaXFQE=;
        b=j6WHuuNsRrclj88Ci2SSWCfw+ndh2oFk6LcMQULkxa495V2XwECzP/jbuL+wGXBwV3
         cAG46TRShaN+d1vE3wbCh3MwnEi26Zq4gUVcxC+ezVVmMPRFdIl8NhbASzsNXt1H4we2
         o1ZpptWojxyqsTQ06IPAXinCiLzGtvEom/wYaLKvN6NxA/Mra8D9MZqH2JKl9Gc/ij4p
         fQF0P/y3PwrGTJiIfxvt/ffIPFHZTe6dxNooGA5PgNQFbzpFWjoJ99ZOUjCCRbwJoksO
         4a91nqL3+On8nWjzc4Tfj3K7EiLs1zuhVJvdkYfNFvtyzLyhUdg0pKv5navHi4mW1DZU
         BLgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=PUIdRGTZnL511IPwlLCU9M17oDUYX9EP4DtFSDaXFQE=;
        b=D0kQ8Y8rhOuJi5A0QiXptr8z0rQgArQ/orDMXqCajyZm13dM3zHXPmE5tYxK1O+jVn
         WK9FY7xwC6sPc/6iYocXpxOoloJ3YPj4WH90V/shfvKvkT/hP2hhciA3/uhLkT8EC6rC
         FHrE9XLhsmhQET2fJeazZxr5xbBi113U+tO3xyEplRt1XtauxYdg3RrGdgI/XONf2d9g
         KZSHiPCYvVbOY2/EjByd5xPDeXO+qb3y0Kv2vD0GUcuaRfYxS2JBL1+1enx2WLbLhozn
         mIFqV/8pR3EYlsalIH9i2ma1WTQFwvqwt/JS3zoUmDMIBWwtrR/q3+OzLotOtHTpXdju
         cGkQ==
X-Gm-Message-State: APjAAAWxcQmm9BgDYt1stz7vd9OdWBaOmAjKziyZcYZN86jrKH/1yZWm
        DcSWcpOzilkaaCooB4f4+GPgE2D2sA==
X-Google-Smtp-Source: APXvYqxAU7Q60L6fzzo4WtEGzDlA2sMtkHpdmfh98X2EsyB728/kWGtuhWzlmqEtuZ+YL4ps0KK2oQ==
X-Received: by 2002:a5e:d911:: with SMTP id n17mr6425188iop.32.1565436253751;
        Sat, 10 Aug 2019 04:24:13 -0700 (PDT)
Received: from [120.7.1.38] (24-212-162-55.cable.teksavvy.com. [24.212.162.55])
        by smtp.gmail.com with ESMTPSA id n7sm74236732ioo.79.2019.08.10.04.24.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 10 Aug 2019 04:24:13 -0700 (PDT)
Subject: Kernel 5.3.x, 5.2.2+: VMware player suspend on 64/32 bit guests
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
References: <2e70a6e2-23a6-dbf2-4911-1e382469c9cb@gmail.com>
 <CAM6Zs0WqdfCv=EGi5qU5w6Dqh2NHQF2y_uF4i57Z9v=NoHHwPA@mail.gmail.com>
 <CAM6Zs0X_TpRPSR9XRikkYxHSA4vZsFr7WH_pEyq6npNjobdRVw@mail.gmail.com>
 <11dc5f68-b253-913a-4219-f6780c8967a0@intel.com>
 <594c424c-2474-5e2c-9ede-7e7dc68282d5@gmail.com>
 <CAM6Zs0XzBvoNFa5CSAaEEBBJHcxvguZFRqVOVdr5+JDE=PVGVw@mail.gmail.com>
 <alpine.DEB.2.21.1908100811160.7324@nanos.tec.linutronix.de>
From:   Woody Suwalski <terraluna977@gmail.com>
Message-ID: <fbcf3c93-3868-2b0e-b831-43fa68c48d6c@gmail.com>
Date:   Sat, 10 Aug 2019 07:24:14 -0400
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:52.0) Gecko/20100101 Firefox/52.0
 SeaMonkey/2.49.4
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.1908100811160.7324@nanos.tec.linutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Moving the thread to LKML, as suggested by Thomas...
>
>> ---------- Forwarded message ---------
>> From: Woody Suwalski <terraluna977@gmail.com>
>> Date: Thu, Aug 1, 2019 at 3:45 PM
>> Subject: Intermittent suspend on 5.3 / 5.2
>> To: Rafael J. Wysocki <rjw@rjwysocki.net>
>>
>>
>> Hi Rafał,
>> I know that you are investigating some issues between these 2 kernels,
>> however I see probably an unrelated problem with suspend on 5.3 and
>> 5.2.4. I think it has creeped in to 5.1.21 as well, but not sure (it is
>> intermittent). So far 4.20.17 works OK, and  I think 5.2.0 works OK.
>> The problem I see is on both 32 and 64 bit VMs, in VMware workstation
>> 15. The VM is trying to suspend when no activity. It leaves out a black
>> box with cursor in top-left position. Upon wakeup from VMware it goes to
>> vmware pre-bios screen, and then expands the black box to the run-size
>> and switches to X.
>> The problem with new kernels is that (I think) the suspend fails - the
>> black box with cursor is there, but seems bigger, and of course is not
>> wake'able (have to reset). In kern.log suspend seems be running OK, and
>> then new dmesg lines kick in, and no obvious culprit.
>> So looking for a free advice .
>> a. You already know what it is
>> b. You may have suggestions as to which upstream patch could be to blame
>> c. I should boot with some debug params (console_off=0, or some other?)
>> and get some real info?
>>
>> BTW. For suspend to work I had to override mem_sleep to [shallow], or
>> maybe later to [s2idle] (the actual VMs are at work, referring from
>> memory...)
>>
>> If you have any ideas, all are welcomed
>> Thanks, Woody



On 8/6/2019 3:18 PM, Woody Suwalski wrote:
> Rafal, the patch (in 5.3-rc3)
>
> Fixes: f850a48a0799 ("ACPI: PM: Allow transitions to D0 to occur in
> special cases")
>
> does not fix the issue - it must be something else...

Sorry for the late response.

There are known issues in 5.3-rc related to power management which 
should be fixed in -rc4.  Please try that one when it is out.

Cheers!



Thomas Gleixner wrote:
> Woody,
>
> On Fri, 9 Aug 2019, Woody Suwalski wrote:
>
> For future things like this, please CC LKML. There is nothing secrit here
> and CC'ing the mailing list allows other people to find this and spare
> themself the whole bisection pain. Asided of that private mail does not
> scale. On the list other people can look at it and give input eventually.
>
>> After bisecting I have found the potential culprit:
>> dfe0cf8b  x86/ioapic: Implement irq_get irqchip_state() callback
>>
>> I am repeating the bisection from start to re-confirm.
>>
>> Reverse-patch on 5.3-rc3 (64bit) is fixing the problem for me.
>> What is unclear - just adding the patch to 5.2.1 does not seem to
>> break it. So there is some more magic involved.
> Of course it does not do anything because 5.2.1 is not having
>
> f4999a2a3a48 ("genirq: Add optional hardware synchronization for shutdown")
>   
>> Thomas, any suggestions?
> What that means is that there is an interrupt shutdown which hits the
> condition where an interrupt _IS_ marked in the IOAPIC as delivered to a
> CPU, but not serviced yet.
>
> Now the question is why it is not serviced. suspend_device_irqs() is
> calling into synchronize_irq(), which is probably the place where that
> it hangs. But that's called with CPUs online and interrupts enabled.
>
>> The reproduce methodology: use VMware player 15, either 32 or 64 bit build.
>> reboot and run "systemctl suspend". The first suspend works OK. The
>> second usually locks on kernels 5.2.2 and up. Maybe try 4 times to
>> confirm good (it is intermittent).
> -ENOVMWAREPLAYER and I'm traveling so I don't have a machine handy to
> install it. So if you can't debug it deeper down, I'm not going to have a
> chance to look at it before the end of next week.
>
> That said, can we please move this to LKML?
>
> Thanks,
>
> 	tglx
>
>
I can add some printk's into synchronize_irq(), however no idea if they 
will be survive in the kmsg log after a next power-reset. I can wait for 
a week :-)

Thanks, Woody

