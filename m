Return-Path: <SRS0=i7el=ZO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,LOTS_OF_MONEY,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE88DC432C0
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 16:21:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 994BA20672
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 16:21:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727493AbfKVQVZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Nov 2019 11:21:25 -0500
Received: from nl101-2.vfemail.net ([149.210.219.31]:60817 "EHLO
        freequeue.vfemail.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726638AbfKVQVZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Nov 2019 11:21:25 -0500
Received: (qmail 26028 invoked from network); 22 Nov 2019 16:19:55 -0000
Received: from nl101-2.vfemail.net (bmE=@149.210.219.31)
  by freequeue.vfemail.net with (DHE-RSA-AES256-SHA encrypted) SMTP; 22 Nov 2019 16:19:55 -0000
Received: (qmail 48931 invoked from network); 21 Nov 2019 01:50:23 -0000
Received: by simscan 1.4.0 ppid: 48800, pid: 48884, t: 0.3604s
         scanners:none
Received: from unknown (HELO Phenom-II-x6.niklas.com) (SGdudGt3aXNAdmZlbWFpbC5uZXQ=@192.168.1.192)
  by nl101.vfemail.net with ESMTPA; 21 Nov 2019 01:50:22 -0000
X-Assp-Version: 2.6.3(19169) on ASSP.nospam
X-Assp-ID: ASSP.nospam m1-01105-10555
X-Assp-Session: 7F93C5ACC9E8 (mail 1)
X-Assp-Envelope-From: Hgntkwis@vfemail.net
X-Assp-Intended-For: pozega.tomislav@gmail.com
X-Assp-Intended-For: linux-kernel@vger.kernel.org
X-Assp-Client-TLS: yes
Received: from 71-208-83-203.ftmy.qwest.net ([71.208.83.203]
         helo=Phenom-II-x6.niklas.com) by ASSP.nospam with SMTPSA(TLSv1_2
         ECDHE-RSA-AES256-GCM-SHA384) (2.6.3); 21 Nov 2019 01:51:42 +0000
Date:   Wed, 20 Nov 2019 20:51:19 -0500
From:   David Niklas <Hgntkwis@vfemail.net>
To:     Tom Psyborg <pozega.tomislav@gmail.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] why do sensors break CPU scaling
Message-ID: <20191120205119.41cd5989@Phenom-II-x6.niklas.com>
In-Reply-To: <CAKR_QVLJZPDfjbQ4CBDv62ok0qG4jq_M_Baq6eaot6GzrKMMwA@mail.gmail.com>
References: <CAKR_QVLJZPDfjbQ4CBDv62ok0qG4jq_M_Baq6eaot6GzrKMMwA@mail.gmail.com>
X-Mailer: Claws Mail 3.17.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 20 Nov 2019 21:42:12 +0100
Tom Psyborg <pozega.tomislav@gmail.com> wrote:
> Hi
> 
> Recently I've needed to set lowest CPU scaling profile, running ubuntu
> 16.04.06 I used standard approach - echoing powersave to
> /sys/devices/system/cpu/cpu*/cpufreq/scaling_governor.
> This did not work as the
> /sys/devices/system/cpu/cpu*/cpufreq/cpuinfo_cur_freq kept returning
> max scaling freq.
> 
> During testing of ubuntu 19.10 I've found that the above approach
> actually does work, but as long as there are no xsensors (or just
> sensors from cli) being run.
> cpuinfo_cur_freq in this case was returning variable values +- 1% of
> around 1.4GHz.
> As soon as I issue sensors command cpuinfo_cur_freq jumps to 3.5GHz
> for a fraction of second and returns back to 1.4GHz afterwards. If
> running xsensors it keeps bouncing between 1.4 and 3.5GHz all the
> time.
> 
> Rebooted back to 16.04.6 and was able to set lowest CPU scaling freq
> as well, but issuing sensors command here once just breaks CPU scaling
> that now remains at about 3.5GHz.
> It can be set to lowest scaling freq again without rebooting but it
> needs to change scaling_governor for all cores to something else and
> then back to powersave.
> 
> Why is this happening, shouldn't sensors command just read temp/fan
> values without writing to any of the CPU control registers?

I don't know if the maintainers will notice your email, but I did. I
don't guarantee that they'll notice or help you, but this should assist
you in writing a proper question.
You need to include the output of uname -a on both ubuntu boxes. The
output of:
dpkg -l xsensors
dpkg -l lm-sensors

The information on which processor you own and the motherboard and
it's BIOS version just in case.

This is just my understanding and it might be wrong, but the CPU is
probably accessed to do the request to the fan values and so it ramps up
expecting to have to deal with a more intense workload (which is exactly
what Ryzen and several newer Intel processors are supposed to do), and so
you're seeing expected behavior.
I've no idea how you'd change this.
Alternatively, and this is just a theory, you could have some program on
the system changing the behavior of the CPU just after you change it to
what you want it to be. As in, inotify is involved.

You're welcome,
David

-------------------------------------------------
This free account was provided by VFEmail.net - report spam to abuse@vfemail.net
 
ONLY AT VFEmail! - Use our Metadata Mitigator to keep your email out of the NSA's hands!
$24.95 ONETIME Lifetime accounts with Privacy Features!  
15GB disk! No bandwidth quotas!
Commercial and Bulk Mail Options!  
