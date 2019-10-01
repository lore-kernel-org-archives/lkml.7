Return-Path: <SRS0=YRFP=X2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63E70C352AA
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 19:23:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2034421920
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 19:23:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vJHfoi6b"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726682AbfJATX1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Oct 2019 15:23:27 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:44900 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726046AbfJATX1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Oct 2019 15:23:27 -0400
Received: by mail-io1-f65.google.com with SMTP id w12so22876439iol.11;
        Tue, 01 Oct 2019 12:23:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=fD1eJLVO0JJPtdpqOnPzje1I6wl0PbbpoiQSZZcRxFs=;
        b=vJHfoi6bRymTqeYFbGskEql0J6h4NQak1yoiYOQDM4RDfPOm0bJVa+a97moZ6LaBtN
         Y5WdyKSZRPHbMw/uIGRgk4+g393BfiC4mY6rvbEgcoauo+k97MPF+i/MQ6NplEtdV72T
         5+ejgOXIQkxJPVVlZCOZMjL0/QkPFAJqAOwUTvU+3VZq7ozU1X8KLQT3EOtU2TObw5lF
         YJ3xwB5gMYKcF01JeC4gkRXixo7EEyPWOflr0OUwIcVjB60bbHFdUgUbadMXZ/6uN2Nz
         HgX7Yrj7o0Qc0i6+HuE8KK0T6AUgud6jQI8SDmMmG761zIOYPzwR3najPOUtUGJbvreK
         9UHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=fD1eJLVO0JJPtdpqOnPzje1I6wl0PbbpoiQSZZcRxFs=;
        b=Xnih9ZnYiHXid3VBDfjXlg5dtdR8OifNxf6WiuwdX5OsOI6cRwviLgFA0/aWnozvAB
         QpToxoS5MstPWTTW9IW3mD3BpKGk3gPBcBPdjsACZlbpoH52RZeMNsrKxbJO4LbnhBHA
         /DUq7GVM+VjZutc1vrg2dTPEQmo6HWQM9qGkyxUm4C//1ljB82nL4VW/iv7C6z5zK8b/
         kQaLkk//XDe1wbiDSn9VQiYMGWgPYxGDAZzxKueMxzXZCoFgHKu90aHaagCUMQEsbZAP
         4cbulxTAj4fnvqbRZueq4SaDu3K1MXMtTMGQFXrcV8Aby3n6Uru5aF0/pQG9gExoeNV1
         WzJQ==
X-Gm-Message-State: APjAAAVCvYkNnTraLnZe4qkDnLNOZxFiVGSa3jPfxes9LHwJg5NlglGU
        krv0YwoHWRA3HS93pz/7JVbTuWX9
X-Google-Smtp-Source: APXvYqxwXCb513lse0bjhb5AAnPCninRiZa8aLzA0/dVYXnd93ebxZktT8UiCf++5ONUOcgQfDBpXQ==
X-Received: by 2002:aed:2806:: with SMTP id r6mr31812166qtd.206.1569957804670;
        Tue, 01 Oct 2019 12:23:24 -0700 (PDT)
Received: from quaco.ghostprotocols.net (179-240-185-49.3g.claro.net.br. [179.240.185.49])
        by smtp.gmail.com with ESMTPSA id n44sm14831090qtf.51.2019.10.01.12.23.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Oct 2019 12:23:23 -0700 (PDT)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 1E98340DA4; Tue,  1 Oct 2019 16:23:19 -0300 (-03)
Date:   Tue, 1 Oct 2019 16:23:19 -0300
To:     Alan Stern <stern@rowland.harvard.edu>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Brendan Gregg <brendan.d.gregg@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Luis =?iso-8859-1?Q?Cl=E1udio_Gon=E7alves?= <lclaudio@redhat.com>
Subject: Re: [PATCH 06/24] tools headers uapi: Sync linux/usbdevice_fs.h with
 the kernel sources
Message-ID: <20191001192319.GE13904@kernel.org>
References: <20191001111216.7208-7-acme@kernel.org>
 <Pine.LNX.4.44L0.1910010957340.1991-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L0.1910010957340.1991-100000@iolanthe.rowland.org>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Tue, Oct 01, 2019 at 09:59:55AM -0400, Alan Stern escreveu:
> On Tue, 1 Oct 2019, Arnaldo Carvalho de Melo wrote:
> 
> > From: Arnaldo Carvalho de Melo <acme@redhat.com>
> > 
> > To pick up the changes from:
> > 
> >   4ed3350539aa ("USB: usbfs: Add a capability flag for runtime suspend")
> >   7794f486ed0b ("usbfs: Add ioctls for runtime power management")
> > 
> > This triggers these changes in the kernel sources, automagically
> > supporting these new ioctls in the 'perf trace' beautifiers.
> > 
> > Soon this will be used in things like filter expressions for tracepoints
> > in 'perf record', 'perf trace', 'perf top', i.e. filter expressions will
> > do a lookup to turn things like USBDEVFS_WAIT_FOR_RESUME into _IO('U',
> > 35) before associating the tracepoint expression to tracepoint perf
> > event.
> > 
> >   $ tools/perf/trace/beauty/usbdevfs_ioctl.sh  > before
> >   $ cp include/uapi/linux/usbdevice_fs.h tools/include/uapi/linux/usbdevice_fs.h
> >   $ git diff
> >   diff --git a/tools/include/uapi/linux/usbdevice_fs.h b/tools/include/uapi/linux/usbdevice_fs.h
> >   index 78efe870c2b7..cf525cddeb94 100644
> >   --- a/tools/include/uapi/linux/usbdevice_fs.h
> >   +++ b/tools/include/uapi/linux/usbdevice_fs.h
> >   @@ -158,6 +158,7 @@ struct usbdevfs_hub_portinfo {
> >    #define USBDEVFS_CAP_MMAP                      0x20
> >    #define USBDEVFS_CAP_DROP_PRIVILEGES           0x40
> >    #define USBDEVFS_CAP_CONNINFO_EX               0x80
> >   +#define USBDEVFS_CAP_SUSPEND                   0x100
> > 
> >    /* USBDEVFS_DISCONNECT_CLAIM flags & struct */
> > 
> >   @@ -223,5 +224,8 @@ struct usbdevfs_streams {
> >     * extending size of the data returned.
> >     */
> >    #define USBDEVFS_CONNINFO_EX(len)  _IOC(_IOC_READ, 'U', 32, len)
> >   +#define USBDEVFS_FORBID_SUSPEND    _IO('U', 33)
> >   +#define USBDEVFS_ALLOW_SUSPEND     _IO('U', 34)
> >   +#define USBDEVFS_WAIT_FOR_RESUME   _IO('U', 35)
> > 
> >    #endif /* _UAPI_LINUX_USBDEVICE_FS_H */
> >   $ tools/perf/trace/beauty/usbdevfs_ioctl.sh  > after
> >   $ diff -u before after
> >   --- before	2019-09-27 11:41:50.634867620 -0300
> >   +++ after	2019-09-27 11:42:07.453102978 -0300
> >   @@ -24,6 +24,9 @@
> >    	[30] = "DROP_PRIVILEGES",
> >    	[31] = "GET_SPEED",
> >    	[32] = "CONNINFO_EX",
> >   +	[33] = "FORBID_SUSPEND",
> >   +	[34] = "ALLOW_SUSPEND",
> >   +	[35] = "WAIT_FOR_RESUME",
> >    	[3] = "RESETEP",
> >    	[4] = "SETINTERFACE",
> >    	[5] = "SETCONFIGURATION",
> >   $
> > 
> > This addresses the following perf build warning:
> > 
> >   Warning: Kernel ABI header at 'tools/include/uapi/linux/usbdevice_fs.h' differs from latest version at 'include/uapi/linux/usbdevice_fs.h'
> >   diff -u tools/include/uapi/linux/usbdevice_fs.h include/uapi/linux/usbdevice_fs.h
> 
> This may sound silly, and undoubtedly the question has been asked 
> before.  Nevertheless...
> 
> Why go to the time and trouble to detect differences between 
> tools/include/uapi/linux/usbdevice_fs.h and 
> include/uapi/linux/usbdevice_fs.h?  Why not just make the first a 
> symbolic link to the second?  Or get rid of the first entirely, and 
> change the source code so that it #include's the second?

We can't use anything from outside tools/perf/ to build it, sometimes
things get changed by kernel developers and tooling breaks.

Another reason is that we want to be able to do:

[acme@quaco perf]$ make help | grep perf
  perf-tar-src-pkg    - Build perf-5.3.0.tar source tarball
  perf-targz-src-pkg  - Build perf-5.3.0.tar.gz source tarball
  perf-tarbz2-src-pkg - Build perf-5.3.0.tar.bz2 source tarball
  perf-tarxz-src-pkg  - Build perf-5.3.0.tar.xz source tarball
[acme@quaco perf]$

Take that tarball, transfer it to an older system and still have it
building and working.

We also use the build warnings as hints that something needs to be
changed in tooling to pick up new kernel features, such as new ioctls,
syscall arguments to handle in 'perf trace', etc.

- Arnaldo
