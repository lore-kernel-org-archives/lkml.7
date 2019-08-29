Return-Path: <SRS0=brkd=WZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=FAKE_REPLY_C,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1899C3A59F
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 15:36:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BFFFF2073F
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 15:36:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727421AbfH2Pgj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Aug 2019 11:36:39 -0400
Received: from mx0a-002e3701.pphosted.com ([148.163.147.86]:5392 "EHLO
        mx0a-002e3701.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726739AbfH2Pgi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Aug 2019 11:36:38 -0400
Received: from pps.filterd (m0150242.ppops.net [127.0.0.1])
        by mx0a-002e3701.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x7TFaNRL000722
        for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2019 15:36:37 GMT
Received: from g4t3426.houston.hpe.com (g4t3426.houston.hpe.com [15.241.140.75])
        by mx0a-002e3701.pphosted.com with ESMTP id 2uphaj03nw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2019 15:36:37 +0000
Received: from g9t2301.houston.hpecorp.net (g9t2301.houston.hpecorp.net [16.220.97.129])
        by g4t3426.houston.hpe.com (Postfix) with ESMTP id 896A259
        for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2019 15:36:36 +0000 (UTC)
Received: from swahl-linux (swahl-linux.americas.hpqcorp.net [10.33.153.21])
        by g9t2301.houston.hpecorp.net (Postfix) with ESMTP id 656454C;
        Thu, 29 Aug 2019 15:36:36 +0000 (UTC)
Date:   Thu, 29 Aug 2019 10:36:36 -0500
From:   Steve Wahl <steve.wahl@hpe.com>
To:     linux-kernel@vger.kernel.org, "Meyer, Kyle" <kyle.meyer@hpe.com>
Subject: Re: The patch relocation overflows
Message-ID: <20190829153636.GE29967@swahl-linux>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <DF4PR8401MB1001719084F52EDA195DF5579BA20@DF4PR8401MB1001.NAMPRD84.PROD.OUTLOOK.COM>
User-Agent: Mutt/1.12.1 (2019-06-15)
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.70,1.0.8
 definitions=2019-08-29_07:2019-08-29,2019-08-29 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 clxscore=1015
 suspectscore=0 phishscore=0 malwarescore=0 adultscore=0 priorityscore=1501
 mlxlogscore=999 lowpriorityscore=0 spamscore=0 impostorscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-1906280000
 definitions=main-1908290166
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 29, 2019 at 10:19:55AM -0500, Meyer, Kyle wrote:
> Hi Steve,
> 
> 
> My patch series was accepted so I don't have much to work on currently, is
> there anything I can help you with?
> 
> 
> Thank you

Why yes, there is!

Loading the tip of the tree kernel, in my case on top of SLES12sp4, I
could not get the kdump kernel to load properly.

I've actually got a fix for it (reverting a commit), but I'm working
on narrowing it down to a fix rather than a revert.  I've already
involved the linux list, some details are below, except I typo'd on
the commit hash (missed the first character on the copy / paste), it
should be b059f801a937.

If you could see if you can reproduce the same problem to start with,
you could help me.

Load up SLES12sp4.

Make sure the kernel command line is using crashkernel=512M,high.

Build and install the community kernel.

Reboot into that kernel.

run "systemctl status kdump" until kdump installation completes -- I
get a failure, do you?  If not we need to figure out why.

If you run dmesg | tail, you should also see a kexec relocation
overflow message.

After you get that far, we'll see where I'm at and what you can do to
help.

--> Steve


On Wed, Aug 28, 2019 at 02:42:26PM -0500, Steve Wahl wrote:
> Please CC me on responses to this.
> 
> I normally would do more diligence on this, but the timing is such
> that I think it's better to get this out sooner.
> 
> With the tip of the tree from https://github.com/torvalds/linux.git (a
> few days old, most recent commit fetched is
> bb7ba8069de933d69cb45dd0a5806b61033796a3), I'm seeing "kexec: Overflow
> in relocation type 11 value 0x11fffd000" when I try to load a crash
> kernel with kdump. This seems to be caused by commit
> 059f801a937d164e03b33c1848bb3dca67c0b04, which changed the compiler
> flags used to compile purgatory.ro, apparently creating 32 bit
> relocations for things that aren't necessarily reachable with a 32 bit
> reference.  My guess is this only occurs when the crash kernel is
> located outside 32-bit addressable physical space.
> 
> I have so far verified that the problem occurs with that commit, and
> does not occur with the previous commit.  For this commit, Thomas
> Gleixner mentioned a few of the changed flags should have been looked
> at twice.  I have not gone so far as to figure out which flags cause
> the problem.
> 
> The hardware in use is a HPE Superdome Flex with 48 * 32GiB dimms
> (total 1536 GiB).
> 
> One example of the exact error messages seen:
> 
> 019-08-28T13:42:39.308110-05:00 uv4test14 kernel: [   45.137743] kexec: Overflow in relocation type 11 value 0x17f7affd000
> 2019-08-28T13:42:39.308123-05:00 uv4test14 kernel: [   45.137749] kexec-bzImage64: Loading purgatory failed
> 
> --> Steve Wahl
> --
> Steve Wahl,  Hewlett Packard Enterprise

On Thu, Aug 29, 2019 at 10:19:55AM -0500, Meyer, Kyle wrote:
> Hi Steve,
> 
> 
> My patch series was accepted so I don't have much to work on currently, is
> there anything I can help you with?
> 
> 
> Thank you
> 
> ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
> From: Wahl, Steve <steve.wahl@hpe.com>
> Sent: Friday, August 23, 2019 4:16:38 PM
> To: Meyer, Kyle <kyle.meyer@hpe.com>
> Subject: Re: The patch
>  
> 
> unfortunately, uv4test23 was mostly taken by someone else today.
> 
> 
> On uv4test14, I first tried with my own copy of the upstream kernel, then I
> snuck on to uv4test23 and grabbed a copy of your kernel directory.  I still
> keep getting relocation errors when kexec tries to load the crash kernel.  Did
> you ever see anything like this?
> 
> 
> v4test14:~ # dmesg | grep kexec
> [  141.497797] kexec: Overflow in relocation type 11 value 0x17f7affd000
> [  141.497802] kexec-bzImage64: Loading purgatory failed
> [  480.183448] kexec: Overflow in relocation type 11 value 0x17f7affd000
> [  480.183453] kexec-bzImage64: Loading purgatory failed
> [  512.094071] kexec: Overflow in relocation type 11 value 0x17f7affd000
> [  512.094076] kexec-bzImage64: Loading purgatory failed
> 
> --> Steve
> 
> ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
> From: Meyer, Kyle <kyle.meyer@hpe.com>
> Sent: Thursday, August 22, 2019 10:06:11 AM
> To: Wahl, Steve <steve.wahl@hpe.com>
> Subject: Re: The patch
>  
> 
> I have uv4test23 reserved until 5:00 today, it's booted up with the upstream
> kernel on fs0. I've already change hpe-auto-config also. Feel free to use it
> anytime!
> 
> 
> Thanks
> 
> ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
> From: Meyer, Kyle <kyle.meyer@hpe.com>
> Sent: Wednesday, August 21, 2019 5:18:05 PM
> To: Wahl, Steve <steve.wahl@hpe.com>
> Subject: Re: The patch
>  
> 
> Hi Steve,
> 
> 
> Thanks for sending me that, I'll come in early tomorrow morning and get another
> machine booted up with the upstream kernel. I got one running and consistently
> crashing but someone has it reserved after me.
> 
> 
> Thanks
> 
> ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
> From: Wahl, Steve <steve.wahl@hpe.com>
> Sent: Wednesday, August 21, 2019 4:30:10 PM
> To: Meyer, Kyle <kyle.meyer@hpe.com>
> Subject: The patch
>  
> 
> When the time comes, the attached file is the change I'm running that matters.
> 
> 
> I have other stuff that dumps the page tables, but this is the meat.  Raw, not
> suitable for submitting upstream, of course.
> 
> 
> --> Steve
> 


-- 
Steve Wahl, Hewlett Packard Enterprise
