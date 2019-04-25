Return-Path: <SRS0=Q+aa=S3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8318EC10F11
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 00:44:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 49F10208E4
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 00:44:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MHC2cPC9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728132AbfDYAoz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 20:44:55 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:41034 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726455AbfDYAoy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 20:44:54 -0400
Received: by mail-pl1-f194.google.com with SMTP id d9so4229873pls.8;
        Wed, 24 Apr 2019 17:44:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ZByeP/U/Xsd+bzaA85yvOt7T/npZJcZ57cO9BOcxw9k=;
        b=MHC2cPC9MLaoJAmE0CQN2S97KWBqkPkLXs9f+lzC+8TPecWG2IM3XWlk4gYZd7AaMD
         20TYn191QK9PLMw5yBzhtLf8+6iS2/O0pVoQsRgHp8Gv3kflNQwkNfGQpgaJPoTiRu8c
         FNW52u2xkj2adCr8HGTYq9Q0v7rjOgp9dRdAcDno1UnknHgKYjI1faCRBpBfpQ8Srb9J
         njMYRHV1PqkT1MLU4IsSFYCM0U39NGDM8i6nKuv5Dxs9ZUKp1AkPpOCKq5JF6a0bZzlM
         XnTkPt5GY3LlwDkH16Usygfj4fExjFxgSQbr+8Deb9GM8KqE6wDqdnLNbCa88ymTeLaK
         ECeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ZByeP/U/Xsd+bzaA85yvOt7T/npZJcZ57cO9BOcxw9k=;
        b=nKkGsa4nxvgp5JjVhahYr3MSusuwt/ZieckZkcywRKtXHb1xpLlYOGE+mOYNgYfuWP
         akR2nYz2sxPA2t4vOQzS/b7mKYl2C4rHH5f7JLB5t19vi9AZKb9zr42AXSBBi/hJE+pr
         g8Isuzoorgt/gBLzWYT9HseVWWxyatgbzfPiDaEVh/IKC3frf1OESg/yOReHp5cvC5tT
         /R1Dnu4AkB1bYaK2hRxiy1ob2RKQrSk9fOn5aPH0t8b/pc+C48IVnrI+AvI45RM9sbah
         LpIuo/5lBshLzZs1auJhpV4r92RbHbCc6JoaNuduJgrfDNTstiO4WB08apghVLWmoty0
         aZUw==
X-Gm-Message-State: APjAAAXWfHzE6M56ikzKyXK6opIo5ZaXfKTdOvK3LUcAYln2YZ2ecSOg
        AA2Z+S5xK3lMghXarHzXJCg=
X-Google-Smtp-Source: APXvYqwiA2jiYqMbnX8meUdO/rblXtj9B6eFO73auf+KnxKT4SbqW+4arNMPnXTszoQF0bAOgYPKww==
X-Received: by 2002:a17:902:b617:: with SMTP id b23mr33814911pls.73.1556153093960;
        Wed, 24 Apr 2019 17:44:53 -0700 (PDT)
Received: from mail.google.com ([104.238.181.70])
        by smtp.gmail.com with ESMTPSA id j9sm42583869pfc.43.2019.04.24.17.44.52
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 24 Apr 2019 17:44:52 -0700 (PDT)
Date:   Thu, 25 Apr 2019 00:44:51 +0000
From:   Changbin Du <changbin.du@gmail.com>
To:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Cc:     Changbin Du <changbin.du@gmail.com>, rjw@rjwysocki.net,
        Jonathan Corbet <corbet@lwn.net>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, fenghua.yu@intel.com,
        linuxppc-dev@lists.ozlabs.org, linux-acpi@vger.kernel.org,
        linux-gpio@vger.kernel.org
Subject: Re: [PATCH v5 20/23] Documentation: ACPI: move cppc_sysfs.txt to
 admin-guide/acpi and convert to reST
Message-ID: <20190425004450.qdajhnzlanufxhx3@mail.google.com>
References: <20190424175306.25880-1-changbin.du@gmail.com>
 <20190424175306.25880-21-changbin.du@gmail.com>
 <20190424151236.776d9678@coco.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190424151236.776d9678@coco.lan>
User-Agent: NeoMutt/20180716-508-7c9a6d
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 24, 2019 at 03:12:36PM -0300, Mauro Carvalho Chehab wrote:
> Em Thu, 25 Apr 2019 01:53:03 +0800
> Changbin Du <changbin.du@gmail.com> escreveu:
> 
> > This converts the plain text documentation to reStructuredText format and
> > add it to Sphinx TOC tree. No essential content change.
> > 
> > Signed-off-by: Changbin Du <changbin.du@gmail.com>
> > ---
> >  .../acpi/cppc_sysfs.rst}                      | 71 ++++++++++---------
> >  Documentation/admin-guide/acpi/index.rst      |  1 +
> >  2 files changed, 40 insertions(+), 32 deletions(-)
> >  rename Documentation/{acpi/cppc_sysfs.txt => admin-guide/acpi/cppc_sysfs.rst} (51%)
> > 
> > diff --git a/Documentation/acpi/cppc_sysfs.txt b/Documentation/admin-guide/acpi/cppc_sysfs.rst
> > similarity index 51%
> > rename from Documentation/acpi/cppc_sysfs.txt
> > rename to Documentation/admin-guide/acpi/cppc_sysfs.rst
> > index f20fb445135d..a4b99afbe331 100644
> > --- a/Documentation/acpi/cppc_sysfs.txt
> > +++ b/Documentation/admin-guide/acpi/cppc_sysfs.rst
> > @@ -1,5 +1,11 @@
> > +.. SPDX-License-Identifier: GPL-2.0
> >  
> > -	Collaborative Processor Performance Control (CPPC)
> > +==================================================
> > +Collaborative Processor Performance Control (CPPC)
> > +==================================================
> > +
> > +CPPC
> > +====
> >  
> >  CPPC defined in the ACPI spec describes a mechanism for the OS to manage the
> >  performance of a logical processor on a contigious and abstract performance
> > @@ -10,31 +16,28 @@ For more details on CPPC please refer to the ACPI specification at:
> >  
> >  http://uefi.org/specifications
> >  
> > -Some of the CPPC registers are exposed via sysfs under:
> > -
> > -/sys/devices/system/cpu/cpuX/acpi_cppc/
> 
> 
> > -
> > -for each cpu X
> 
> Yeah, there it is: you're removing those two lines.
>
They are indented, see below diffs. I did remove "-----...." two lines.
> > +Some of the CPPC registers are exposed via sysfs under::
> >  
> > ---------------------------------------------------------------------------------
> > +  /sys/devices/system/cpu/cpuX/acpi_cppc/
> 
> As per my reply to v4.
> 
> Thanks,
> Mauro

-- 
Cheers,
Changbin Du
