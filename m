Return-Path: <SRS0=tJqY=VY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0697C433FF
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Jul 2019 13:33:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8FC482075C
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Jul 2019 13:33:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387684AbfG0Nd1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Jul 2019 09:33:27 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:37142 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387607AbfG0Nd1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Jul 2019 09:33:27 -0400
Received: by mail-ot1-f67.google.com with SMTP id s20so58112684otp.4
        for <linux-kernel@vger.kernel.org>; Sat, 27 Jul 2019 06:33:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8pKsm0Glo5GvWJ2FgAFUVIAU/XUG0KKO3Gz3Fqbr57A=;
        b=IVBwLfASsUtSGfo1Eo51WnALde6DFG3DJaoTntK9i3KALzG1YUeKkOT2wAVwUK4F1r
         ewbi7ZjIZe0u00hQj14EC839i4Jh6srsYpS2tpSxIpGen7SbgdATs1P0aCPvdxS6/qMJ
         r/EngmmLO+0zzOTc/Gw3VYQh/oydwh0P3NXRcbSLsF3zggJE5JMWeO3yEYQYrIXOrjco
         Sri1ggrDjTlEEWyfctpp27+tvzVuw0pIzfZmnr1IkbfSVd59+xZUlRJykzIyr6amdRxR
         bkZ+YE96UOdrr3OlM4qTlBYXAxw/YqF+k2YXNULtEE26l4LDptnfg0YO1LEH0GR62fHC
         WHGg==
X-Gm-Message-State: APjAAAWhP2/WieKrovioOFYXtVxcGOAs+LPO6SL412porUVE8R7LB6ZH
        4lfitJU3ADHAzlZhUFRlfYGJAlaRXbQv8r0ht74THw==
X-Google-Smtp-Source: APXvYqyAbW1b8uSXlX1kLfH6Wz3b/HKGqixPASzcQcxCPj1SJ/ze1kYlHQlYZ5Gx2uUiwFUm8rQ2kx+E3q/bIM3MDzo=
X-Received: by 2002:a9d:7a90:: with SMTP id l16mr22763240otn.297.1564234406426;
 Sat, 27 Jul 2019 06:33:26 -0700 (PDT)
MIME-Version: 1.0
References: <20190722095024.19075-1-hch@lst.de> <20190726233753.GD2166993@magnolia>
In-Reply-To: <20190726233753.GD2166993@magnolia>
From:   Andreas Gruenbacher <agruenba@redhat.com>
Date:   Sat, 27 Jul 2019 15:33:14 +0200
Message-ID: <CAHc6FU7L52soLiRafnOiTsaMYp4X_NmjjimpMMzdaoSH_afT+A@mail.gmail.com>
Subject: Re: lift the xfs writepage code into iomap v3
To:     "Darrick J. Wong" <darrick.wong@oracle.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        linux-xfs@vger.kernel.org,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 27 Jul 2019 at 01:38, Darrick J. Wong <darrick.wong@oracle.com> wrote:
> On Mon, Jul 23, 2019 at 11:50:12AM +0200, Christoph Hellwig wrote:
> > Hi all,
> >
> > this series cleans up the xfs writepage code and then lifts it to
> > fs/iomap.c so that it could be use by other file system.  I've been
> > wanting to this for a while so that I could eventually convert gfs2
> > over to it, but I never got to it.  Now Damien has a new zonefs
> > file system for semi-raw access to zoned block devices that would
> > like to use the iomap code instead of reinventing it, so I finally
> > had to do the work.
>
> Hmm... I don't like how there are xfs changes mixed in with the iomap
> changes, because were I to take this series as-is then I'd have to
> commit both to adding iomap writeback code /and/ converting xfs at the
> same time.
>
> I think I'd be more comfortable creating a branch to merge the changes
> to list.h and fs/iomap/, and then gfs2/zonefs/xfs can sprout their own
> branches from there to do whatever conversions are necessary.
>
> To me what that means is splitting patch 7 into 7a which does the iomap
> changes and 7b which does the xfs changes.  To get there, I'd create a
> iomap-writeback branch containing:
>
> 1 7a 8 9 10 11 12
>
> and then a new xfs-iomap-writeback branch containing:
>
> 2 4 7b
>
> This eliminates the need for patches 3, 5, and 6, though the cost is
> that it's less clear from the history that we did some reorganizing of
> the xfs writeback code and then moved it over to iomap.  OTOH, I also
> see this as a way to lower risk because if some patch in the
> xfs-iomap-writeback branch shakes loose a bug that doesn't affect gfs2
> or zonedfs we don't have to hold them up.
>
> I'll try to restructure this series along those lines and report back
> how it went.

Keeping the infrastructure changes in separate commits would certainly
make the patches easier to work with for me. Keeping the commits
interleaved should be fine though: patch "iomap: zero newly allocated
mapped blocks" depends on "xfs: set IOMAP_F_NEW more carefully", so a
pure infrastructure branch without "xfs: set IOMAP_F_NEW more
carefully" probably wouldn't be correct.

Thanks,
Andreas
