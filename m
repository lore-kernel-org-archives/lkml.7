Return-Path: <SRS0=XKeO=YB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4233AC4360C
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 12:56:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 23F232070B
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 12:56:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731055AbfJHM4U (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Oct 2019 08:56:20 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52458 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730670AbfJHM4U (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Oct 2019 08:56:20 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 1074AA26682;
        Tue,  8 Oct 2019 12:56:20 +0000 (UTC)
Received: from 10.255.255.10 (unknown [10.40.205.32])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 7EE285DA2C;
        Tue,  8 Oct 2019 12:56:13 +0000 (UTC)
Date:   Tue, 8 Oct 2019 14:56:10 +0200
From:   Karel Zak <kzak@redhat.com>
To:     Ian Kent <raven@themaw.net>
Cc:     Hugh Dickins <hughd@google.com>, Laura Abbott <labbott@redhat.com>,
        David Howells <dhowells@redhat.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Linux-MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org
Subject: Re: mount on tmpfs failing to parse context option
Message-ID: <20191008125610.s4fgnnba7yhclb3z@10.255.255.10>
References: <d5b67332-57b7-c19a-0462-f84d07ef1a16@redhat.com>
 <d7f83334-d731-b892-ee49-1065d64a4887@redhat.com>
 <alpine.LSU.2.11.1910071655060.4431@eggly.anvils>
 <59784f8ac4d458a09d40706b554432b283083938.camel@themaw.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <59784f8ac4d458a09d40706b554432b283083938.camel@themaw.net>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2 (mx1.redhat.com [10.5.110.68]); Tue, 08 Oct 2019 12:56:20 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 08, 2019 at 08:38:18PM +0800, Ian Kent wrote:
> > That's because the options in shmem_parse_options() are
> > "size=4G,nr_inodes=0", which indeed looks like an attempt to
> > retroactively limit size; but the user never asked "size=4G" there.
> 
> I believe that's mount(8) doing that.
> I don't think it's specific to the new mount api.
> 
> AFAIK it's not new but it does mean the that things that come
> through that have been found in mtab by mount(8) need to be
> checked against the current value before failing or ignored if
> changing them is not allowed.
> 
> I wonder if the problem has been present for quite a while but
> gone unnoticed perhaps.
> 
> IIUC the order should always be command line options last and it
> must be that way to honour the last specified option takes
> precedence convention.
> 
> I thought this was well known, but maybe I'm wrong ... and TBH
> I wasn't aware of it until recently myself.

Yep, the common behavior is "the last option wins". See man mount,
remount option:

  remount  functionality  follows  the standard way the mount command
  works with options from fstab.  This means that mount does not read
  fstab (or mtab) only when both device and dir are specified.

        mount -o remount,rw /dev/foo /dir

  After this call all old mount options are replaced and arbitrary
  stuff from fstab (or mtab) is ignored, except the loop= option which
  is  internally  generated  and  maintained by the mount command.

        mount -o remount,rw  /dir

  After  this call, mount reads fstab and merges these options with
  the options from the command line (-o).  If no mountpoint is found
  in fstab, then a remount with unspeci‐ fied source is allowed.


If you do not like this classic behavior than recent mount(8) versions
provide --options-mode={ignore,append,prepend,replace} to keep it in
your hands.


    Karel

> 
> > 
> > Hugh
> 

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
