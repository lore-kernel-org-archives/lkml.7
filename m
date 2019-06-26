Return-Path: <SRS0=hRvo=UZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC9DBC48BD3
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 16:54:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 974D320665
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 16:54:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Uj4+Dutx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726407AbfFZQyI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Jun 2019 12:54:08 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:39690 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726042AbfFZQyI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jun 2019 12:54:08 -0400
Received: by mail-wm1-f66.google.com with SMTP id z23so2813998wma.4;
        Wed, 26 Jun 2019 09:54:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NVIRAAtuHMary0ENvTqI42u8ePAFlB34oJ5LNbAJXwY=;
        b=Uj4+Dutxp0oOp7DvRBLLMEqpFj3YvImXcHklj3JeAM4F7Iugd4viDS8GgbnZG4rdU1
         Z2kUpdOU5Y9gMyN3IONNSnPOdnEeZ2twWuNYHox8nh7qJTzSytkGqksczh+lIApguqUq
         ly1j0b9JlBO9ZmYWxg/QcWObciSQYo24zi1WxX05PnFqrbXliQ038fDpO0u7o2fmj0V3
         v84aFNrcfx+CY2I+GQSdTokimf4fGXe0hMIxY5HaK8XlLx1yaJX9hV34a1B1CSpoaf1X
         qLPqAlktBAckzbc6DBBT0Tfr+00jztXdL0WQ1xHXRC5cHbdxjwU2AsZxoVLSNUkt48gY
         QqJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NVIRAAtuHMary0ENvTqI42u8ePAFlB34oJ5LNbAJXwY=;
        b=DQIUFUHD3wxzUx3Qo4WA4stAFvvcx/mHavbAa6cG/8FWAIED6ca5+m2oW0Urgst5zh
         kN2keLmHFk5k6IoldC87LaXbJL0Aw6QZEFA5r82cWqw5mHA+XSQDwoLUQ+dt3g0EuCpc
         P6oriT99ymLl+o1X+/nYkWWzeZZ6xEVh3qx9W03vev2K5cljBplkikbqfVCXgaZ/pF/U
         3cd3QUR37UGMMmdxhYKNHBmumZoBjH1tO7mlFMimAeoMKBPx8ggbvZLdYLdOS6Ali/GC
         oc8Wi9/JZuSsNZsIRCYbIsOA7VoEqtJfdetTNlwThaVugntl0meWtMMjnVX2yQT4s1Ul
         CPyg==
X-Gm-Message-State: APjAAAVNwuLA6qUcE7Hn5NsxgnYXYlz7lhVlldV4ZEA3xn0rrNw+M6mI
        gQBHh61osBtKUISmoX/1TCjyMB/+D8gNKryxbjjxTvyBKcY=
X-Google-Smtp-Source: APXvYqztcH8hEvDR4mIsPPK8JdTZnA3daM9rwL/To1XkCxrFtrVoNcBKy7jzBWuI4DGM+YGpovX2wa0tycPOixX0yiA=
X-Received: by 2002:a05:600c:2205:: with SMTP id z5mr3574669wml.175.1561568044565;
 Wed, 26 Jun 2019 09:54:04 -0700 (PDT)
MIME-Version: 1.0
References: <20190622151947.29115-1-tranmanphong@gmail.com> <20190625153658.53ad0e18@lwn.net>
In-Reply-To: <20190625153658.53ad0e18@lwn.net>
From:   Phong Tran <tranmanphong@gmail.com>
Date:   Wed, 26 Jun 2019 23:53:53 +0700
Message-ID: <CAD3AR6H8DSTXZkTEmrhhbDzWZ48OA6=HNuYx2oEzddROjntzxA@mail.gmail.com>
Subject: Re: [PATCH] scsi: convert to rst for documenation
To:     linux-scsi@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>
Cc:     Shuah Khan <skhan@linuxfoundation.org>, martin.petersen@oracle.com,
        axboe@kernel.dk, avri.altman@wdc.com, beanhuo@micron.com,
        evgreen@chromium.org, Henrik Austad <henrik@austad.us>,
        jpittman@redhat.com, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 26, 2019 at 4:37 AM Jonathan Corbet <corbet@lwn.net> wrote:
>
> On Sat, 22 Jun 2019 22:19:47 +0700
> Phong Tran <tranmanphong@gmail.com> wrote:
>
> > - Update to the link in documenation
> > - Remove trailing white space
> > - Adaptation the sphinx doc syntax
> >
> > Signed-off-by: Phong Tran <tranmanphong@gmail.com>
>
> Thanks for working to improve the documentation!  That said, I think this
> patch needs a fair amount of work before we are ready to accept it.  I'll
> only get partway in, but it should be enough to start with.
>
> The first overall thing I would like to point out (and hopefully the SCSI
> folks won't fight me too much on this) is that Documentation/scsi is the
> wrong place for much of this stuff.  We are doing our best to organize the
> documentation with the audience in mind.  So, for example, documents that
> are of interest to system administrators should go into
> Documentation/admin-guide.  Information for driver developers should go in
> Documentation/driver-api.  And so on.
>
in my understanding,
link_power_management_policy.txt and scsi-parameters.txt should be in
Documentation/admin-guide correct?
scsi_mid_low_api.txt should be moved to Documentation/driver-api?

> [...]
>
> > diff --git a/Documentation/scsi/link_power_management_policy.rst b/Documentation/scsi/link_power_management_policy.rst
> > new file mode 100644
> > index 000000000000..170f58c94cac
> > --- /dev/null
> > +++ b/Documentation/scsi/link_power_management_policy.rst
> > @@ -0,0 +1,22 @@
> > +SCSI Power Management Policy
> > +============================
> > +
> > +This parameter allows the user to set the link (interface) power management.
> > +There are 3 possible options:
>
> This isn't your fault, but...*which* parameter allows this?  The document
> describes the values, but not where they can be set.  That makes it less
> than fully useful.
>
> > ++-------------------+------------------------------------------------------+
> > +| Value             | Effect                                               |
> > ++===================+======================================================+
> > +| min_power         | Tell the controller to try to make the link use the  |
> > +|                   | least possible power when possible. This may         |
> > +|                   | sacrifice some performance due to increased latency  |
> > +|                   | when coming out of lower power states.               |
> > ++-------------------+------------------------------------------------------+
> > +| max_performance   | Generally, this means no power management. Tell      |
> > +|                   | the controller to have performance be a priority     |
> > +|                   | over power management.                               |
> > ++-------------------+------------------------------------------------------+
> > +| medium_power      | Tell the controller to enter a lower power state     |
> > +|                   | when possible, but do not enter the lowest power     |
> > +|                   | state, thus improving latency over min_power setting.|
> > ++-------------------+------------------------------------------------------+
>
> [...]
>
> > diff --git a/Documentation/scsi/scsi-changer.txt b/Documentation/scsi/scsi-changer.rst
> > similarity index 71%
> > rename from Documentation/scsi/scsi-changer.txt
> > rename to Documentation/scsi/scsi-changer.rst
> > index ade046ea7c17..a4923873c77b 100644
> > --- a/Documentation/scsi/scsi-changer.txt
> > +++ b/Documentation/scsi/scsi-changer.rst
> > @@ -1,4 +1,3 @@
> > -
> >  README for the SCSI media changer driver
> >  ========================================
> >
> > @@ -10,7 +9,7 @@ common small CD-ROM changers, neither one-lun-per-slot SCSI changers
> >  nor IDE drives.
> >
> >  Userland tools available from here:
> > -     http://linux.bytesex.org/misc/changer.html
> > +    http://linux.bytesex.org/misc/changer.html
> >
> >
> >  General Information
> > @@ -28,15 +27,17 @@ The SCSI changer model is complex, compared to - for example - IDE-CD
> >  changers. But it allows to handle nearly all possible cases. It knows
> >  4 different types of changer elements:
> >
> > +::
>
> Two notes:
>
>  - You can put the double colon on the line above ("...elements::") and
>    don't need to make a separate line for it.
>
>  - But, more to the point, please avoid the temptation to use a literal
>    block for something that doesn't actually require that treatment. This
>    should be reworked as an RST definition list.
>
> >    media transport - this one shuffles around the media, i.e. the
> >                      transport arm.  Also known as "picker".
> >    storage         - a slot which can hold a media.
> >    import/export   - the same as above, but is accessible from outside,
> >                      i.e. there the operator (you !) can use this to
> >                      fill in and remove media from the changer.
> > -                 Sometimes named "mailslot".
> > +            Sometimes named "mailslot".
> >    data transfer   - this is the device which reads/writes, i.e. the
> > -                 CD-ROM / Tape / whatever drive.
> > +            CD-ROM / Tape / whatever drive.
>
> [...]
>
> > diff --git a/Documentation/scsi/scsi-generic.txt b/Documentation/scsi/scsi-generic.rst
> > similarity index 70%
> > rename from Documentation/scsi/scsi-generic.txt
> > rename to Documentation/scsi/scsi-generic.rst
> > index 51be20a6a14d..8356810160f0 100644
> > --- a/Documentation/scsi/scsi-generic.txt
> > +++ b/Documentation/scsi/scsi-generic.rst
> > @@ -1,8 +1,10 @@
> > -            Notes on Linux SCSI Generic (sg) driver
> > -            ---------------------------------------
> > -                                                        20020126
> > +=======================================
> > +Notes on Linux SCSI Generic (sg) driver
> > +=======================================
> > +20020126
> > +
> >  Introduction
> > -============
> > +------------
> >  The SCSI Generic driver (sg) is one of the four "high level" SCSI device
> >  drivers along with sd, st and sr (disk, tape and CDROM respectively). Sg
> >  is more generalized (but lower level) than its siblings and tends to be
> > @@ -16,20 +18,20 @@ and examples.
> >
> >
> >  Major versions of the sg driver
> > -===============================
> > +-------------------------------
> >  There are three major versions of sg found in the linux kernel (lk):
> > -      - sg version 1 (original) from 1992 to early 1999 (lk 2.2.5) .
> > -     It is based in the sg_header interface structure.
> > +      - sg version 1 (original) from 1992 to early 1999 (lk 2.2.5) .
> > +        It is based in the sg_header interface structure.
> >        - sg version 2 from lk 2.2.6 in the 2.2 series. It is based on
> > -     an extended version of the sg_header interface structure.
> > +        an extended version of the sg_header interface structure.
> >        - sg version 3 found in the lk 2.4 series (and the lk 2.5 series).
> > -     It adds the sg_io_hdr interface structure.
> > +        It adds the sg_io_hdr interface structure.
>
> Perhaps we don't *really* need to preserve information about what versions
> were around in the 1990's?
>
> >  Sg driver documentation
> > -=======================
> > +-----------------------
> >  The most recent documentation of the sg driver is kept at the Linux
> > -Documentation Project's (LDP) site:
> > +Documentation Project's (LDP) site:
> >  http://www.tldp.org/HOWTO/SCSI-Generic-HOWTO
>
> That document claims to have been last updated in 2002.  Is there really
> nothing more recent than that?
>
> >  This describes the sg version 3 driver found in the lk 2.4 series.
>
> ...and it's unclear to me that users of the 5.x kernel are much concerned
> with what was found in 2.4.
>
> That is the problem with this document in general.  I suspect that about
> the only useful information left in it is the location of the sg3_utils
> source.  I honestly don't think that it helps the documentation that much
> to carry forward ancient information to the RST format.
>
> Of course, doing this right by deleting obsolete information and updating
> the documents to reflect current reality is a *lot* more work.  Probably
> far more than you were thinking of signing up for.  If you were willing to
> work on this, there may be somebody from the SCSI community who would be in
> a position to help you with it.
>
yes! I would greatly appreciate

> Unfortunately, the SCSI community probably did not see this patch because
> you didn't copy the linux-scsi list.  I'll fix that now, but they will not
> have seen your original patch.  You should be sure to include them on
> future postings.
>
Note in next post.

> I would like to make a suggestion, in addition to all of the above: rather
> than trying to do a mass conversion in a single 4000-line patch, start with
> a single file and post a patch doing just that one, being sure to include

yes will send a new patch for each file.

> the linux-scsi list.  That will give everybody something more workable to
> start with.
>
> Thanks,
>
> jon
