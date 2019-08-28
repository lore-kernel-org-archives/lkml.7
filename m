Return-Path: <SRS0=kjqD=WY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBFD8C3A5A1
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 22:14:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B4A5F22DA7
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 22:14:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727056AbfH1WO4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Aug 2019 18:14:56 -0400
Received: from mx0a-002e3701.pphosted.com ([148.163.147.86]:45880 "EHLO
        mx0a-002e3701.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726658AbfH1WO4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Aug 2019 18:14:56 -0400
Received: from pps.filterd (m0134421.ppops.net [127.0.0.1])
        by mx0b-002e3701.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x7SMEjtR009561;
        Wed, 28 Aug 2019 22:14:45 GMT
Received: from g9t5008.houston.hpe.com (g9t5008.houston.hpe.com [15.241.48.72])
        by mx0b-002e3701.pphosted.com with ESMTP id 2uns26v761-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 28 Aug 2019 22:14:45 +0000
Received: from g4t3433.houston.hpecorp.net (g4t3433.houston.hpecorp.net [16.208.49.245])
        by g9t5008.houston.hpe.com (Postfix) with ESMTP id 36ACD6B;
        Wed, 28 Aug 2019 22:10:49 +0000 (UTC)
Received: from swahl-linux (swahl-linux.americas.hpqcorp.net [10.33.153.21])
        by g4t3433.houston.hpecorp.net (Postfix) with ESMTP id A0C1348;
        Wed, 28 Aug 2019 22:10:48 +0000 (UTC)
Date:   Wed, 28 Aug 2019 17:10:48 -0500
From:   Steve Wahl <steve.wahl@hpe.com>
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Steve Wahl <steve.wahl@hpe.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>, russ.anderson@hpe.com,
        dimitri.sivanich@hpe.com, mike.travis@hpe.com
Subject: Re: Purgatory compile flag changes apparently causing Kexec
 relocation overflows
Message-ID: <20190828221048.GB29967@swahl-linux>
References: <20190828194226.GA29967@swahl-linux>
 <CAKwvOdn0=7YabPD-5EUwkSoJgWjdYHY2mirM2LUz0TxZTBOf_Q@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKwvOdn0=7YabPD-5EUwkSoJgWjdYHY2mirM2LUz0TxZTBOf_Q@mail.gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Proofpoint-UnRewURL: 1 URL was un-rewritten
MIME-Version: 1.0
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.70,1.0.8
 definitions=2019-08-28_11:2019-08-28,2019-08-28 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 bulkscore=0
 suspectscore=0 lowpriorityscore=0 adultscore=0 phishscore=0 mlxscore=0
 spamscore=0 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1906280000 definitions=main-1908280213
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 28, 2019 at 02:51:21PM -0700, Nick Desaulniers wrote:
> On Wed, Aug 28, 2019 at 12:42 PM Steve Wahl <steve.wahl@hpe.com> wrote:
> >
> > Please CC me on responses to this.
> >
> > I normally would do more diligence on this, but the timing is such
> > that I think it's better to get this out sooner.
> >
> > With the tip of the tree from https://github.com/torvalds/linux.git  (a
> > few days old, most recent commit fetched is
> > bb7ba8069de933d69cb45dd0a5806b61033796a3), I'm seeing "kexec: Overflow
> > in relocation type 11 value 0x11fffd000" when I try to load a crash
> > kernel with kdump. This seems to be caused by commit
> > 059f801a937d164e03b33c1848bb3dca67c0b04, which changed the compiler
> > flags used to compile purgatory.ro, apparently creating 32 bit
> > relocations for things that aren't necessarily reachable with a 32 bit
> > reference.  My guess is this only occurs when the crash kernel is
> > located outside 32-bit addressable physical space.
> >
> > I have so far verified that the problem occurs with that commit, and
> > does not occur with the previous commit.  For this commit, Thomas
> > Gleixner mentioned a few of the changed flags should have been looked
> > at twice.  I have not gone so far as to figure out which flags cause
> > the problem.
> >
> > The hardware in use is a HPE Superdome Flex with 48 * 32GiB dimms
> > (total 1536 GiB).
> >
> > One example of the exact error messages seen:
> >
> > 019-08-28T13:42:39.308110-05:00 uv4test14 kernel: [   45.137743] kexec: Overflow in relocation type 11 value 0x17f7affd000
> > 2019-08-28T13:42:39.308123-05:00 uv4test14 kernel: [   45.137749] kexec-bzImage64: Loading purgatory failed
> 
> Thanks for the report and sorry for the breakage.  Can you please send
> me more information for how to precisely reproduce the issue?  I'm
> happy to look into fixing it.

Here's the details I know might be important:

Since this appears to be a problem with the result of a relocation not
fitting within 32 bits, I think the location chosen to place the crash
kernel needs to be above 4GiB; so you need a machine with more memory
than that.

At the moment I'm running SLES 12 sp 4 as the rest of the
environment.  rpm says kdump is kdump-0.8.16-9.2.x86_64.  I've fetched
the kernel sources and compiled directly on this system.  I believe I
copied the kernel config from the SLES kernel and did a make
olddefconfig for configuration.  Made and installed the kernel from
the kernel tree.

crashkernel=512M,high is set on the command line.

As the system boots, and systemd initializes kdump, it tries to load
the crash kernel, I believe through
/usr/lib/systemd/system/kdump.service running /lib/kdump/load.sh
--update.

Once that completes, 'systemctl status kdump' indicates a failure, and
dmesg | grep kexec shows the error messages mentioned above.

> Let me go dig up the different listed flags.  Steve, it may be fastest
> for you to test re-adding them in your setup to see which one is
> important.

I will work through that tomorrow and let you know what I find.

> Tglx, if you want to revert the above patches, I'm ok with that.  It's
> important that we fix the issue eventually that my patches were meant
> to address, but precisely *when* it's solved isn't critical; our
> kernels can carry out of tree patches for now until the issue is
> completely resolved worst case.
> -- 
> Thanks,
> ~Nick Desaulniers

Thank you!

--> Steve Wahl

-- 
Steve Wahl, Hewlett Packard Enterprise
