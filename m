Return-Path: <SRS0=hO5d=UX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6660C43613
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 12:58:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 90E0720679
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 12:58:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="UCwvLTFa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730417AbfFXM6y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Jun 2019 08:58:54 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:44564 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726740AbfFXM6x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jun 2019 08:58:53 -0400
Received: by mail-qk1-f195.google.com with SMTP id p144so9585023qke.11
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2019 05:58:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Xx/RWmPWBvyJH2ZU2NlE1zPXjYqIgHNE0+DzqPjHLoo=;
        b=UCwvLTFauBZM95y94QPC9oGAEFrPbOt1jJVDGyUlhejwVII3S37uAzEACDd2yNiWBO
         ZfugWza9SALwHGlXK6Us5p0JFr8g7Uq6jOhsgHGnOv2iLSTaBMMCmFeIlJ/PlMYSoVKY
         7V1p9+PFLFuZxBSv/8oozyk+2ws3ohRQ+lP5KlRHZzB0zyaRdMRtH6GzM0Ybc9IdSt7C
         QYW+6878VyjokxvbhFe/IuwqXjgMMKC4JR2xtAJTacgmn59f49lg93ukqIFU0Wx62B2w
         TrRRXepBonyL+njzjSwQU4tq5njBfTcRcrIsKEVqtWoohLqcA+kGcBYNBJF6vy8F4jB4
         LywQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Xx/RWmPWBvyJH2ZU2NlE1zPXjYqIgHNE0+DzqPjHLoo=;
        b=cXyoQkbnqE4yCjbxKR8dK/Z+zmyDlNMnq4vxBMGoP1q5IDrt9IcXLYphSqYxkwMgjm
         9SzNEFSqoBiNSIRU+7epiY+tfImlemRs65kF1kQisi152ThySyEciQFpkaJZsrag1A2T
         dvE/PwPI1QVHKDyYUbcK+D12JlFFFl0Us2MLrL1+Y6oXW8R4l2VPXEDD5I7d3jgk3iT0
         fUrJ5XmrjD2PMwvwBXLNVyJk1tbp9gHMLmsjToRQ5IXRU7unGRD92Ni+HqCMmVgY9zs/
         0VerY2Iga2SwwHD3gUqmkmTxqwtMhU04KzV76p5vrsRdAkKLdNQNbN0hAk4v2yf2AzG1
         lxgQ==
X-Gm-Message-State: APjAAAVqaY/mXQeevhARpV1ilaL5+Do5hfFUeGbF50Zh89qr3qsv2IKz
        mwi8kQDeFwGuHgnb46WFq8Uyng==
X-Google-Smtp-Source: APXvYqxjWNfQxLfoP+rpGNMOujJkBpLhTS8ucR6j2FpSxRJn0uwMDXTszglfdGdwE/0XbXCQipp1Kw==
X-Received: by 2002:a37:6b07:: with SMTP id g7mr20623988qkc.217.1561381131743;
        Mon, 24 Jun 2019 05:58:51 -0700 (PDT)
Received: from dhcp-41-57.bos.redhat.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id f1sm5502266qke.117.2019.06.24.05.58.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 24 Jun 2019 05:58:50 -0700 (PDT)
Message-ID: <1561381129.5154.55.camel@lca.pw>
Subject: Re: LTP hugemmap05 test case failure on arm64 with linux-next
 (next-20190613)
From:   Qian Cai <cai@lca.pw>
To:     Will Deacon <will@kernel.org>
Cc:     Anshuman Khandual <anshuman.khandual@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-arm-kernel@lists.infradead.org
Date:   Mon, 24 Jun 2019 08:58:49 -0400
In-Reply-To: <20190624093507.6m2quduiacuot3ne@willie-the-truck>
References: <1560461641.5154.19.camel@lca.pw>
         <20190614102017.GC10659@fuggles.cambridge.arm.com>
         <1560514539.5154.20.camel@lca.pw>
         <054b6532-a867-ec7c-0a72-6a58d4b2723e@arm.com>
         <EC704BC3-62FF-4DCE-8127-40279ED50D65@lca.pw>
         <20190624093507.6m2quduiacuot3ne@willie-the-truck>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6 (3.22.6-10.el7) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2019-06-24 at 10:35 +0100, Will Deacon wrote:
> Hi Qian Cai,
> 
> On Sun, Jun 16, 2019 at 09:41:09PM -0400, Qian Cai wrote:
> > > On Jun 16, 2019, at 9:32 PM, Anshuman Khandual <anshuman.khandual@arm.com>
> > > wrote:
> > > On 06/14/2019 05:45 PM, Qian Cai wrote:
> > > > On Fri, 2019-06-14 at 11:20 +0100, Will Deacon wrote:
> > > > > On Thu, Jun 13, 2019 at 05:34:01PM -0400, Qian Cai wrote:
> > > > > > LTP hugemmap05 test case [1] could not exit itself properly and then
> > > > > > degrade
> > > > > > the
> > > > > > system performance on arm64 with linux-next (next-20190613). The
> > > > > > bisection
> > > > > > so
> > > > > > far indicates,
> > > > > > 
> > > > > > BAD:  30bafbc357f1 Merge remote-tracking branch 'arm64/for-
> > > > > > next/core'
> > > > > > GOOD: 0c3d124a3043 Merge remote-tracking branch 'arm64-fixes/for-
> > > > > > next/fixes'
> > > > > 
> > > > > Did you finish the bisection in the end? Also, what config are you
> > > > > using
> > > > > (you usually have something fairly esoteric ;)?
> > > > 
> > > > No, it is still running.
> > > > 
> > > > https://raw.githubusercontent.com/cailca/linux-mm/master/arm64.config
> > > > 
> > > 
> > > Were you able to bisect the problem till a particular commit ?
> > 
> > Not yet, it turned out the test case needs to run a few times (usually
> > within 5) to reproduce, so the previous bisection was totally wrong where
> > it assume the bad commit will fail every time. Once reproduced, the test
> > case becomes unkillable stuck in the D state.
> > 
> > I am still in the middle of running a new round of bisection. The current
> > progress is,
> > 
> > 35c99ffa20ed GOOD (survived 20 times)
> > def0fdae813d BAD
> 
> Just wondering if you got anywhere with this? We've failed to reproduce the
> problem locally.

Unfortunately, I have not had a chance to dig this up yet. The progress I had so
far is,

The issue was there for a long time goes back to 4.20 and probably earlier. It
is not failing every time. The script below could reproduce it usually within 10
0 tires.

i=0; while :; do ./hugemmap05 -m -s; echo $((i++)); sleep 5; done

This can be reproduced in an error path, i.e., shmget() in the test case will
fail every time before triggering the soft lockups.

# ./hugemmap05 -s -m
tst_test.c:1112: INFO: Timeout per run is 0h 05m 00s
hugemmap05.c:235: INFO: original nr_hugepages is 0
hugemmap05.c:248: INFO: original nr_overcommit_hugepages is 0
tst_safe_sysv_ipc.c:111: BROK: hugemmap05.c:97: shmget(218366029, 103079215104,
b80) failed: ENOMEM
hugemmap05.c:192: INFO: restore nr_hugepages to 0.
hugemmap05.c:201: INFO: restore nr_overcommit_hugepages to 0.

Summary:
passed   0
failed   0
skipped  0
warnings 0
0

My understanding is that the soft lockups are triggered in this path,

ipcget
  ipcget_public
    ops->getnew
      newseg
        hugetlb_file_setup <- return ENOMEM

[ 1521.471216][ T1309] INFO: task hugemmap05:4718 blocked for more than 860
seconds.
[ 1521.478731][ T1309]       Tainted: G        W         5.2.0-rc4+ #8
[ 1521.485023][ T1309] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs"
disables this message.
[ 1521.493568][ T1309] hugemmap05      D27168  4718      1 0x00000001
[ 1521.499815][ T1309] Call trace:
[ 1521.502985][ T1309]  __switch_to+0x2e0/0x37c
[ 1521.507278][ T1309]  __schedule+0xa0c/0xd9c
[ 1521.511484][ T1309]  schedule+0x60/0x168
[ 1521.515430][ T1309]  __rwsem_down_write_failed_common+0x484/0x7b8
[ 1521.521546][ T1309]  rwsem_down_write_failed+0x20/0x2c
[ 1521.526717][ T1309]  down_write+0xa0/0xa4
[ 1521.530747][ T1309]  ipcget+0x74/0x414
[ 1521.534518][ T1309]  ksys_shmget+0x90/0xc4
[ 1521.538638][ T1309]  __arm64_sys_shmget+0x54/0x88
[ 1521.543366][ T1309]  el0_svc_handler+0x198/0x260
[ 1521.548005][ T1309]  el0_svc+0x8/0xc
[ 1521.551605][ T1309] 
[ 1521.551605][ T1309] Showing all locks held in the system:
[ 1521.559349][ T1309] 1 lock held by khungtaskd/1309:
[ 1521.564251][ T1309]  #0: 00000000033dd0e2 (rcu_read_lock){....}, at:
rcu_lock_acquire+0x8/0x38
[ 1521.573014][ T1309] 2 locks held by hugemmap05/4694:
[ 1521.578010][ T1309] 1 lock held by hugemmap05/4718:
[ 1521.582904][ T1309]  #0: 00000000c62a3d44 (&ids->rwsem){....}, at:
ipcget+0x74/0x414
[ 1521.590707][ T1309] 1 lock held by hugemmap05/4755:
[ 1521.595595][ T1309]  #0: 00000000c62a3d44 (&ids->rwsem){....}, at:
ipcget+0x74/0x414
[ 1521.603373][ T1309] 1 lock held by hugemmap05/4781:
[ 1521.608270][ T1309]  #0: 00000000c62a3d44 (&ids->rwsem){....}, at:
ipcget+0x74/0x414
