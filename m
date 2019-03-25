Return-Path: <SRS0=yZjE=R4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAC60C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 20:02:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A69620850
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 20:02:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=tycho.nsa.gov header.i=@tycho.nsa.gov header.b="cJqANCno"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729922AbfCYUCn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 16:02:43 -0400
Received: from uhil19pa09.eemsg.mail.mil ([214.24.21.82]:37409 "EHLO
        uhil19pa09.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728912AbfCYUCm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 16:02:42 -0400
X-Greylist: delayed 589 seconds by postgrey-1.27 at vger.kernel.org; Mon, 25 Mar 2019 16:02:41 EDT
X-EEMSG-check-017: 2835561|UHIL19PA09_EEMSG_MP7.csd.disa.mil
Received: from emsm-gh1-uea10.ncsc.mil ([214.29.60.2])
  by uhil19pa09.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 25 Mar 2019 19:52:51 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=tycho.nsa.gov; i=@tycho.nsa.gov; q=dns/txt;
  s=tycho.nsa.gov; t=1553543571; x=1585079571;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=WfisdA6pgf4+ZRdgKRHsyph3IO/NxqlTZnmGTF4p764=;
  b=cJqANCnosUTrvl0iZJRbtSTP9AWIPwc2bfIOZY0jp/LxFBbXaVyk8lka
   D/8XkLiJyUryxHt6zc3sj0IwLb4alWiZKZLgIj+xAj6FXk3u3mcjqRYZm
   JImq2py1PM12nIfm9bOvY5Dbq/vcuH2C222YmbiErqtGcytQnOuoq9iHl
   RoFipSCJOT7gRjn36a+t1/M958HcXQM0PRLJPI0BWdyzNKFPzjxEDRaFC
   oZLi9x79wJfO1M78+qO26TJZk6em9FrLMsLeaoELZhn1dSedLqU8CHJ0P
   7mYlkE8EvWr/a1mGOuDXaHpKDZAJ9zoW2rBb/5trt2oJAMkDbwmEaTL0e
   A==;
X-IronPort-AV: E=Sophos;i="5.60,270,1549929600"; 
   d="scan'208";a="21817426"
IronPort-PHdr: =?us-ascii?q?9a23=3AhkGqcxKfOTdBKVwNhdmcpTZWNBhigK39O0sv0r?=
 =?us-ascii?q?FitYgXLvjzrarrMEGX3/hxlliBBdydt6sczbWG+Pm6BiQp2tWoiDg6aptCVh?=
 =?us-ascii?q?sI2409vjcLJ4q7M3D9N+PgdCcgHc5PBxdP9nC/NlVJSo6lPwWB6nK94iQPFR?=
 =?us-ascii?q?rhKAF7Ovr6GpLIj8Swyuu+54Dfbx9HiTagfb9+Nhe7oAbeusULn4dvKLs6xw?=
 =?us-ascii?q?fUrHdPZ+lY335jK0iJnxb76Mew/Zpj/DpVtvk86cNOUrj0crohQ7BAAzsoL2?=
 =?us-ascii?q?465MvwtRneVgSP/WcTUn8XkhVTHQfI6gzxU4rrvSv7sup93zSaPdHzQLspVz?=
 =?us-ascii?q?mu87tnRRn1gygJLT459HzchNJ2gqxVvRmtowVzzo7QbY2QMvd1Y6HTcs4ARW?=
 =?us-ascii?q?dZQ8hfSSJBDIO/YYUBAeUOMuRXoJXyqVYVsRuzBhOhCP/zxjJGhHL727Ax3e?=
 =?us-ascii?q?Q7EQHB2QwtB88AsGjKo9XtNKcdT+a1x7TVwzXGdfxW3TP955bIcxs8pvyMRq?=
 =?us-ascii?q?9/cdHKxEkzFwLKklWQqYv/MzOTzeQCqXKX7+VnVeKxkmMqrRx6rDu3xso0l4?=
 =?us-ascii?q?XEiY0YxkrE+Clk2oo5O9K1RFBhbdK5FpZbqjuUOJFsQsw4RmFloCM6yrobtp?=
 =?us-ascii?q?GlZCUK05EnxwLHa/yAboiI/grvVOaPLjd8g3JoYK6/iAyo8Uih1+38TdO40E?=
 =?us-ascii?q?pKryVZktnMsWoB1xrP5cicVvRx5EKh2TeL1wzL6+FEJ147lbbDJpI8zbM9mY?=
 =?us-ascii?q?AfvETeEiPshkn7g7Gael859uSw7uToeLTmppuSN49ujQH+N7wjmteiDuQjKQ?=
 =?us-ascii?q?UOQ2ia9vi81L3k50H5Rq5KgecsnqnWt5DaO9wXprSlDA9NzoYj9xG/Ai+n0d?=
 =?us-ascii?q?QEmnkHKl1FdQmZj4j1IV3BPu33DeqniVS2jDhr3+zGPqHmApjVKnjDkbHhfa?=
 =?us-ascii?q?ty6kJFywo808pf55RKBbEFO//zREDxu8LCDhMjMAy73fznCNNj2YMaQ26PBb?=
 =?us-ascii?q?WZMKzKu1+S+u0vO/WMZJMSuDvlL/gl5vjujWI2mFMEZqmmw4cYaG2iHvRnP0?=
 =?us-ascii?q?WYYWPggtIGEWgXowo+SPLlhUacUT5ceXmyRbgw5jIlB4K8C4fMWIStjKaG3C?=
 =?us-ascii?q?ehEZ1cfnpGBUyUEXf0a4WEXO8BZziRIs95lzwJTryhS44n1RGzuw720rRnLu?=
 =?us-ascii?q?3J+i0eqJ3szsR15+zUlRE07zB0CN6d026VRWFugmwIXyM23Lx4oUFlz1eD0a?=
 =?us-ascii?q?94jOBbFdxU/P5JSRo6NYXCwOBgF9/yXQfBdM+TSFm6WtWmHS0xTtUpztATeU?=
 =?us-ascii?q?l9Hc+ujhLZ0yukAr8Vk7iLBJ0u/aLZxHj8PMd9y3Da1KY/i1kqWNdANWqjhq?=
 =?us-ascii?q?Rn7QjcG5bJk1mFl6atbakcxi/N+3mFzWqSvkFXThVwXL7KXXAYYUvWotD56V?=
 =?us-ascii?q?3YQ7CyDrQnNxNLydSeJatSdt3pkVJGSe/5N9vEeWK+h32/BRCHxrySd4fqYX?=
 =?us-ascii?q?sS0zjdCEcejwAf52qJNQ87Bi25uWLRECRuFU7zY0Pr6eRxtWm0TlEqwAyRdE?=
 =?us-ascii?q?1hy7W1+hkRhfOGUPwTxagIuCE/pDVoBFy9xc7ZC8Kcpwp9e6VRedA94FZd1W?=
 =?us-ascii?q?LYswx9OoasL7tihl4DbwR4oUbu1xJpCohblcgqrXUqzBd9KK6C0VNBcS+Y0o?=
 =?us-ascii?q?70OrHNNmby+xWvYbbM2l7CyNaW5rsP6PMgplX4vAGmCEwi8nt53NlTyHSc4Y?=
 =?us-ascii?q?7KDA8TUZL1TEk67Bd6p7TAbSk844PYz2FjMa6xsmyK59V8OOwjxSSgdtFQeP?=
 =?us-ascii?q?eWCAj0HOUEG46jJPF83xCNTTcgdLRW9agpL4aleuGA1aqDIulthnSlgH5B7Y?=
 =?us-ascii?q?Q71ViDoW40Tu/OwoZA2PyTwxGGSya5iVCtr8T6sZ5LaCtUHWelzyXgQolLaf?=
 =?us-ascii?q?5cZ4EOXFyyLtW3y9M2vJvkX3pV5Rb3HF8d8NO4chqVKVrm1Etf0lpB8i/voj?=
 =?us-ascii?q?ex0zEhy2JhlaGYxiGbhrmzeQ=3D=3D?=
X-IPAS-Result: =?us-ascii?q?A2BmAQAQMJlc/wHyM5BkDg0BAQEBAwEBAQcDAQEBgWWBZ?=
 =?us-ascii?q?yqBODOENZQKAQEBAQEBBoE1fohHiWGFKIFnOgGEQAKFEiI4EgEBAwEBAQgBA?=
 =?us-ascii?q?wIBbCiCOimCZwEBAQECASMPAQVBEAkCGAICJgICVwYBDAgBAYJfP4FpBQiSY?=
 =?us-ascii?q?ZtmgS+FRoRngQskizIXeIEHgREngjY1PoQMBQESAYMpgjUiA6Q2YAmLbYdGB?=
 =?us-ascii?q?hmTfi2Kb5U2IWVxKwgCGAghD4MokA9XIwOBNQEBjGGCPgEB?=
Received: from tarius.tycho.ncsc.mil ([144.51.242.1])
  by EMSM-GH1-UEA10.NCSC.MIL with ESMTP; 25 Mar 2019 19:52:50 +0000
Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto [192.168.25.131])
        by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id x2PJqlSr015899;
        Mon, 25 Mar 2019 15:52:47 -0400
Subject: Re: Repost: Missing security_mmap_file() in remap_file_pages syscall
To:     TongZhang <ztong@vt.edu>, LKML <linux-kernel@vger.kernel.org>,
        linux-security-module@vger.kernel.org
Cc:     akpm@linux-foundation.org, mhocko@suse.com,
        dan.j.williams@intel.com, rientjes@google.com, aarcange@redhat.com,
        dave@stgolabs.net, kirill.shutemov@linux.intel.com,
        Shen Wenbo <shenwenbosmile@gmail.com>
References: <A6FCC3DA-C72C-4B59-A27E-E91F85949608@vt.edu>
From:   Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <3fa343e7-5c22-5a97-cf4f-a9156a0696a7@tycho.nsa.gov>
Date:   Mon, 25 Mar 2019 15:53:34 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.0
MIME-Version: 1.0
In-Reply-To: <A6FCC3DA-C72C-4B59-A27E-E91F85949608@vt.edu>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/25/19 1:33 PM, TongZhang wrote:
> Dear Kernel Developers,
> 
> We’d like to bring this up for a discussion again.
> 
> Several months ago we posted an email discussing a case where remap_file_pages() has no security_mmap_file() check.
> At that time we were told that do_mmap_pgoff() will base the new VMA permission on the old one.
> But somehow we still think the check is needed, for the reason that the advisory could first do a
> mmap() which can pass SELinux check then remap using a completely different file or region of file,
> which could possibly pose a risk.

I don't see an issue there. The incoming prot value from userspace is 
required to be zero (otherwise remap_file_pages returns -EINVAL), so the 
prot passed to do_mmap_pgoff() is entirely computed based on the 
existing vma flags.  The file is likewise obtained from the existing 
vma.  Any flags supplied by the caller other than MAP_NONBLOCK are 
ignored.  MAP_SHARED is always set in the flags passed to 
do_mmap_pgoff(), and the existing vma was required to have VM_SHARED set 
or remap_file_pages() would have returned -EINVAL.  If it spans more 
than one vma, their files and flags must match.  It appears that all of 
the inputs relevant to selinux_mmap_file() are necessarily the same as 
they would have been when creating the original vma.  The same appears 
to also be true for other security modules IIUC.

> 
> Thanks,
> - Tong
> 
> The original post is pasted below:
> 
> 8<—————————————————————————————
> [1.] One line summary of the problem:
> 
> Possible missing security_mmap_file() in remap_file_pages
> 
> [2.] Full description of the problem/report:
> 
> We noticed remap_file_pages syscall uses do_mmap_pgoff without LSM check: security_mmap_file().
> 
> This system call passed user controllable parameters to do_mmap_pgoff().
> 
> We think that this LSM check should be added in order to be consistent with other cases,
> for example:
> in system call mmap_pgoff(), shmat(), they all have security_mmap_file() check before calling
> do_mmap_pgoff().
> 
> [3.] Keywords: LSM check
> [4.] Kernel information
> [4.1] Kernel Version: 4.14.61
> 
> 8<—————————————————————————————
> 
> 
> 
> 
> 

