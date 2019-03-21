Return-Path: <SRS0=/BZh=RY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAFC9C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 20:16:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A53CD218A1
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 20:16:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=netronome-com.20150623.gappssmtp.com header.i=@netronome-com.20150623.gappssmtp.com header.b="saVgs75x"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728803AbfCUUQN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Mar 2019 16:16:13 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:38647 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728316AbfCUUQN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Mar 2019 16:16:13 -0400
Received: by mail-qk1-f194.google.com with SMTP id g1so12911642qki.5
        for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2019 13:16:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netronome-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :organization:mime-version:content-transfer-encoding;
        bh=TZutz0HSRXq5ErCpqJa4uDbIJRNEZqu0EunDY52N++0=;
        b=saVgs75xs/p55sqZXVUuu7J1pH8F37lUPJYRLpSnRXLoZZGh8O5tzqyTyXFxsmRads
         FG+qTs3P3DN9iyeUbqazqfZ5LXmB7aftSgnvaaFuUYUc9ay1IFMLpLu3fh9BklqWDn53
         TPs4RSsAqLHZVIjHDg+9rm8pqlMgUqGMEjrYmKcq3HC7dZpMCGi2UpEuDbDWZP+evWhC
         qF+5xFYYNT/JvEkoxRzX/bVfSF/UeT2fbN1ISSrWnysWrTf6csI7jXUuShSuzB6A9zNI
         1ZFECREmgiKoH63GVh+MULr++Z8IR8BpNVMq58cwutBAR7cQW8MczH3l8a47Wk4YVAF8
         e5GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:organization:mime-version:content-transfer-encoding;
        bh=TZutz0HSRXq5ErCpqJa4uDbIJRNEZqu0EunDY52N++0=;
        b=gpNmlegyAIL8TnlzjZUk46iYeaO2qLhAAQ0R7IejjAChotZHCWQggLpQ9Rlr0yyPd0
         GlZ9LH0r+WZzBnQCx+j7NWdNF7RiJexBJxSeW4GVJWAJUnf5lSViYc249jXFTjCdoYMs
         +3AQBcx4xI1gtMxtDUUBQ1q+iGqMFEpsG3oM0vE4yShaZ7waIZpG46vy0QntZDcuT3Ek
         zubfI8131CYqfsIYyWwqIsBhw+/0Yq7+heiyQswNH5ZqLnCN5u1hkTIIccXgRQcr1x/m
         NohmIoocT2VRwXj9cZO1f9a8wOJ3GSXZ0eX/Ypr4zL9IlQV7ki/9zcgvv2om23DdVb7B
         Ehqw==
X-Gm-Message-State: APjAAAVivAGCcvKq+UACLWIwFn9RNpc+HRKSSBO1QgYiRAHxO9Xru2iS
        /m77Aw6wWwQ/dEWPLlLiWplq2g==
X-Google-Smtp-Source: APXvYqxNgQLRmNooPKdGfhRPS1xKJgkrNlx3cfXBwvnwnl0YivKpPfKmleIr/zJrl6b0wwPptfVbCg==
X-Received: by 2002:a37:aa8c:: with SMTP id t134mr4283678qke.93.1553199371893;
        Thu, 21 Mar 2019 13:16:11 -0700 (PDT)
Received: from cakuba.netronome.com ([66.60.152.14])
        by smtp.gmail.com with ESMTPSA id s5sm3415511qkf.87.2019.03.21.13.16.10
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 21 Mar 2019 13:16:11 -0700 (PDT)
Date:   Thu, 21 Mar 2019 13:16:06 -0700
From:   Jakub Kicinski <jakub.kicinski@netronome.com>
To:     Alban Crequy <alban@kinvolk.io>
Cc:     Alban Crequy <alban.crequy@gmail.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        netdev <netdev@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Iago =?UTF-8?B?TMOzcGV6?= Galeiras <iago@kinvolk.io>
Subject: Re: [PATCH bpf-next v1 4/7] tools: bpftool: implement map exec
 command
Message-ID: <20190321131606.2acb3bb6@cakuba.netronome.com>
In-Reply-To: <CADZs7q7+SATGjCCdiDBfGbTBJh11V6s=o4RAAKhaKvFjfo7O_Q@mail.gmail.com>
References: <20190320173332.18105-1-alban@kinvolk.io>
        <20190320173332.18105-4-alban@kinvolk.io>
        <20190320142346.3b552895@cakuba.netronome.com>
        <CADZs7q7+SATGjCCdiDBfGbTBJh11V6s=o4RAAKhaKvFjfo7O_Q@mail.gmail.com>
Organization: Netronome Systems, Ltd.
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 21 Mar 2019 10:57:32 +0100, Alban Crequy wrote:
> On Wed, Mar 20, 2019 at 10:23 PM Jakub Kicinski
> <jakub.kicinski@netronome.com> wrote:
> >
> > On Wed, 20 Mar 2019 18:33:29 +0100, Alban Crequy wrote:  
> > > From: Alban Crequy <alban@kinvolk.io>
> > >
> > > The map exec commands allows to open an existing map and pass the file
> > > descriptor to a child process. This enables applications to use an
> > > existing BPF map even when they don't support bpffs.
> > >
> > > Example of usage:
> > >     # bpftool map exec pinned /sys/fs/bpf/foo fd 99 cmd -- readlink /proc/self/fd/99
> > >     anon_inode:bpf-map  
> >
> > Would you mind telling us a little more about the use for this feature?
> > It seems fairly limited.  If it's about probing objects (finding out if
> > they are a map or a program) perhaps we can add a command just for that?  
> 
> I needed to know the name of the map too. I was preparing a demo based
> on python bcc tools (opensnoop) but with added feature that requires
> using a pinned map, created and maintained externally. At the moment,
> the python API for bcc does not support pinning or using external
> maps. Ideally, this should be added in the python API (some discussion
> on https://github.com/iovisor/bcc/issues/2223) but meanwhile, I use a
> workaround by executing bpftool from the python code.
> 
> Arguably, my use case is a temporary hack until we have better support
> in python bcc. But other tools implements similar commands to pass
> file descriptors between processes: "ip netns exec" and "tc exec bpf".
> So I think it could be useful for other scripting use cases.

The thing is the receiver of the FD has to be bpf-aware, because there
isn't really much one can do with that file descriptor, in which case
it's kind of strange that the receiver doesn't know how to open a
pinned object..

> In my demo, I used the two hacks:
> - if the pinned map fd is not given to the python script, re-execute
> itself with bpftool:
> os.execvp("bpftool", ["bpftool", "map", "exec", "pinned", pin_path,
> "fd", "90", "cmd", "--"] + sys.argv)
> - once we have the fd 90 (number specified above) of the pinned map in
> the python script, overwrite the empty fd created by bcc:
> os.dup2(90, 6)
> I call dup2() between the bpf map creation and the bpf program
> creation. To check which map fd to overwrite, I just call
> os.system("bpftool map show fd 6...").

I see, thanks for the explanation.  That does indeed seems like a hack.

> Thanks a lot for the reviews. I'll need some time to address it (maybe
> a week or 2).
> 
> > (I guess bpftool -f isn't really the cleanest way of getting at that
> > info.)
> >  
> > > Documentation and bash completion updated as well.
> > >
> > > Signed-off-by: Alban Crequy <alban@kinvolk.io>  

