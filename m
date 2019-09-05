Return-Path: <SRS0=AnJR=XA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87537C43331
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Sep 2019 16:10:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 21E6620693
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Sep 2019 16:10:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="XHsnwvGJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732687AbfIEQK5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Sep 2019 12:10:57 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:38096 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731397AbfIEQK5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Sep 2019 12:10:57 -0400
Received: by mail-qk1-f196.google.com with SMTP id x5so2651410qkh.5
        for <linux-kernel@vger.kernel.org>; Thu, 05 Sep 2019 09:10:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=MJcWwYRIZlVdMWckmfT4XUshiFQ6YOOkK12+Ir5VBak=;
        b=XHsnwvGJdFEAxB2ECjFSz96hU8P06SMz68POkJKj0e6iHfHunTLJ6ffq/FhD3ML1Rz
         Rfm3hSpNvEnqZ4mopDrqHwLEksHCA6LnyWnkoOxzeb6liZy6d52bV6EE5drZLK8slGHp
         QAmfVdB2ve89Yv+V2dUqWa88NC9gKPH6zhW/UlW5C5atM0sYnfvzjNkPTVos4bZkxZCd
         oViIM9DGJyLxz9cOWJU2UM3h81vKajHisRr8UOtClVmcxgOUm5OtF1L/MJdXosjIGw0f
         ogytLrIdzYPk8KZAnY+EkXHfPC1zFhREK/qs+PP0U/6AT5ZmbMHYdT0RnwMRSd7poaF6
         A6lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=MJcWwYRIZlVdMWckmfT4XUshiFQ6YOOkK12+Ir5VBak=;
        b=gLHBNB17BuP5BGaqAhYI3zKIr+DVlUEzTiRpW/T1PSk5EtFw/Ifv8HE1XB9txv6Rc0
         lp++CvxxpcVRaD0LyCPt/GZz1CbZca/A+rTiWpMFVzRv0dgEQ/TcPCgqfguwukWhA+8o
         AzCMQepsXwPRo94xGWhaUxgtW3if1XRMOqoPN7BFRqhXjNst1Mwtr4loMU3gs7pJryRV
         HIaW70JYspSfyJe8vQ2Li4DoGp1bjaKy5i6qWtxKI2k+ogv64aYua4nXq6FFp1gQxNwL
         CJ0LTPS5UYIZ0hoX/3vxdURyrYK05Pq62ZxROyWtU6pDK0LiAu8XCbAf46iaLuGBddre
         q8PQ==
X-Gm-Message-State: APjAAAW/xBr6BAIgZTe0b+r83JkJPex14265RW79MxKfxerwfg0YEgY2
        Xtvtc8RG4Y9A33YZY9uW6wHgnQ==
X-Google-Smtp-Source: APXvYqyXRTABc9mFwjZ3y6ApYMKWe3oG7+ROIYzo5aOQc0yODJboxwxAwsPhdcdKS5r59olUBt382g==
X-Received: by 2002:a37:9cd6:: with SMTP id f205mr3722320qke.500.1567699855894;
        Thu, 05 Sep 2019 09:10:55 -0700 (PDT)
Received: from dhcp-41-57.bos.redhat.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id u28sm1748493qtu.22.2019.09.05.09.10.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 05 Sep 2019 09:10:55 -0700 (PDT)
Message-ID: <1567699853.5576.98.camel@lca.pw>
Subject: Re: [RFC PATCH] mm, oom: disable dump_tasks by default
From:   Qian Cai <cai@lca.pw>
To:     Michal Hocko <mhocko@kernel.org>
Cc:     linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        David Rientjes <rientjes@google.com>,
        LKML <linux-kernel@vger.kernel.org>
Date:   Thu, 05 Sep 2019 12:10:53 -0400
In-Reply-To: <20190903151307.GZ14028@dhcp22.suse.cz>
References: <20190903144512.9374-1-mhocko@kernel.org>
         <1567522966.5576.51.camel@lca.pw> <20190903151307.GZ14028@dhcp22.suse.cz>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6 (3.22.6-10.el7) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2019-09-03 at 17:13 +0200, Michal Hocko wrote:
> On Tue 03-09-19 11:02:46, Qian Cai wrote:
> > On Tue, 2019-09-03 at 16:45 +0200, Michal Hocko wrote:
> > > From: Michal Hocko <mhocko@suse.com>
> > > 
> > > dump_tasks has been introduced by quite some time ago fef1bdd68c81
> > > ("oom: add sysctl to enable task memory dump"). It's primary purpose is
> > > to help analyse oom victim selection decision. This has been certainly
> > > useful at times when the heuristic to chose a victim was much more
> > > volatile. Since a63d83f427fb ("oom: badness heuristic rewrite")
> > > situation became much more stable (mostly because the only selection
> > > criterion is the memory usage) and reports about a wrong process to
> > > be shot down have become effectively non-existent.
> > 
> > Well, I still see OOM sometimes kills wrong processes like ssh, systemd
> > processes while LTP OOM tests with staight-forward allocation patterns.
> 
> Please report those. Most cases I have seen so far just turned out to
> work as expected and memory hogs just used oom_score_adj or similar.

Here is the one where oom01 should be one to be killed.

[92598.855697][ T2588] Swap cache stats: add 105240923, delete 105250445, find
42196/101577
[92598.893970][ T2588] Free swap  = 16383612kB
[92598.913482][ T2588] Total swap = 16465916kB
[92598.932938][ T2588] 7275091 pages RAM
[92598.950212][ T2588] 0 pages HighMem/MovableOnly
[92598.971539][ T2588] 1315554 pages reserved
[92598.990698][ T2588] 16384 pages cma reserved
[92599.010760][ T2588] Tasks state (memory values in pages):
[92599.036265][ T2588] [  pid  ]   uid  tgid total_vm      rss pgtables_bytes
swapents oom_score_adj name
[92599.080129][ T2588]
[   1662]     0  1662    29511     1034   290816      244             0 systemd-
journal
[92599.126163][ T2588]
[   2586]   998  2586   508086        0   368640     1838             0 polkitd
[92599.168706][ T2588]
[   2587]     0  2587    52786        0   421888      500             0 sssd
[92599.210082][ T2588]
[   2588]     0  2588    31223        0   139264      195             0
irqbalance
[92599.255606][ T2588]
[   2589]    81  2589    18381        0   167936      217          -900 dbus-
daemon
[92599.303678][ T2588]
[   2590]     0  2590    97260      193   372736      573             0
NetworkManager
[92599.348957][ T2588]
[   2594]     0  2594    95350        1   229376      758             0 rngd
[92599.390216][ T2588]
[   2598]   995  2598     7364        0    94208      103             0 chronyd
[92599.432447][ T2588]
[   2629]     0  2629   106234      399   442368     3836             0 tuned
[92599.473950][ T2588]
[   2638]     0  2638    23604        0   212992      240         -1000 sshd
[92599.515158][ T2588]
[   2642]     0  2642    10392        0   102400      138             0
rhsmcertd
[92599.560435][ T2588]
[   2691]     0  2691    21877        0   208896      277             0 systemd-
logind
[92599.605035][ T2588]
[   2700]     0  2700     3916        0    69632       45             0 agetty
[92599.646750][ T2588]
[   2705]     0  2705    23370        0   225280      393             0 systemd
[92599.688063][ T2588]
[   2730]     0  2730    37063        0   294912      667             0 (sd-pam)
[92599.729028][ T2588]
[   2922]     0  2922     9020        0    98304      232             0 crond
[92599.769130][ T2588]
[   3036]     0  3036    37797        1   307200      305             0 sshd
[92599.813768][ T2588]
[   3057]     0  3057    37797        0   303104      335             0 sshd
[92599.853450][ T2588]
[   3065]     0  3065     6343        1    86016      163             0 bash
[92599.892899][ T2588] [  38249]     0
38249    58330      293   221184      246             0 rsyslogd
[92599.934457][ T2588] [  11329]     0
11329    55131       73   454656      396             0 sssd_nss
[92599.976240][ T2588] [  11331]     0
11331    54424        1   434176      610             0 sssd_be
[92600.017106][ T2588] [  25247]     0
25247    25746        1   212992      300         -1000 systemd-udevd
[92600.060539][ T2588] [  25391]     0
25391     2184        0    65536       32             0 oom01
[92600.100648][ T2588] [  25392]     0
25392     2184        0    65536       39             0 oom01
[92600.143516][ T2588] oom-
kill:constraint=CONSTRAINT_NONE,nodemask=(null),cpuset=/,mems_allowed=0-
1,global_oom,task_memcg=/system.slice/tuned.service,task=tuned,pid=2629,uid=0
[92600.213724][ T2588] Out of memory: Killed process 2629 (tuned) total-
vm:424936kB, anon-rss:328kB, file-rss:1268kB, shmem-rss:0kB, UID:0
pgtables:442368kB oom_score_adj:0
[92600.297832][  T305] oom_reaper: reaped process 2629 (tuned), now anon-
rss:0kB, file-rss:0kB, shmem-rss:0kB


> 
> > I just
> > have not had a chance to debug them fully. The situation could be worse with
> > more complex allocations like random stress or fuzzy testing.
