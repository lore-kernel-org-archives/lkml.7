Return-Path: <SRS0=t3dz=T5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8D60C28CC0
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 15:29:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF5042183F
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 15:29:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="K16i45JT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726752AbfE2P3U (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 May 2019 11:29:20 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:35246 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726162AbfE2P3T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 May 2019 11:29:19 -0400
Received: by mail-lj1-f193.google.com with SMTP id h11so2933956ljb.2
        for <linux-kernel@vger.kernel.org>; Wed, 29 May 2019 08:29:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zGaoYWpZqQThaCeamoLFUvuaep53rUnIcLcyCp5w/vg=;
        b=K16i45JTnOhNMfVGcEM3dEc/HE4jxUF98k+I1d4LAg3DOuRJvQylZri7olnMGkge0H
         4u/1DHCKb96WcllkEwg/MgRcL7L1CCWB/hO2xL6zPqW540FOdvpqq8ULGBnZRtoyr3fP
         /dGrfil607dUvRtiW7bu8V4ywrGKbWRLqU6mf6azB7C8mCUui5dBAoSANEn7un7OuRYk
         IqepsvKsbnqV/1oKEERjHclI3LARwVOrafGfm/8g8m245GMvIADoi+bQuHeE9itYkX84
         p6l1akwBNRSzQLd+wftooHrEfiVN9zwWBxGF+rHhkqPeWkDXyPffgp3T4WNSYiCr0lTu
         +NzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zGaoYWpZqQThaCeamoLFUvuaep53rUnIcLcyCp5w/vg=;
        b=Sf7mZnWOfQTmVx87QrZz3SwM/qG223Ad0AwZ0GhuabnEqOxZsabKUwYpTV1CR0Oo7A
         GkP7tXAANEsVNS1XrijdQhrX+soWtJL2JY/EaZ6PRt9t0Ba0amoqpD628pe4D/K7MuIp
         2DnSx0d3WK1E2SgrRO8SUGRRcPxwhLW7SwX/VipN4U5+jsaP8iB+fLBfhhduk1jJ17sD
         0vJBUNzi+u07NoCNdtuDWksIGYjMxiHU7X6s2ERhZVjAyuN2DoaVGVbSGEl8E2tuXzyp
         Oxt7k553NUXkX4w28tbv2tXRILkM9TxtSaljFmCyNvB9zv8jwV5xwul3k59FDsqaHEDf
         6AzA==
X-Gm-Message-State: APjAAAUPLoQj254HHdkhdwmX9fDyrrZ4PUyRVGApOgFvKPWUXsPQYF8y
        lHXi0+cURAlkh7Yl/nJ8O+nxLDlo+tKCw1BTOfGO
X-Google-Smtp-Source: APXvYqzA1he5CqqTYdGxCaEGH42J2+OT0TC3I1+seVKjcqbN4107AbF/Fb/yxBclhcMIQ95Q2dNrHCvd5kXZOEP8NA8=
X-Received: by 2002:a2e:92cc:: with SMTP id k12mr2501807ljh.16.1559143756865;
 Wed, 29 May 2019 08:29:16 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1554732921.git.rgb@redhat.com> <9edad39c40671fb53f28d76862304cc2647029c6.1554732921.git.rgb@redhat.com>
 <20190529145742.GA8959@cisco>
In-Reply-To: <20190529145742.GA8959@cisco>
From:   Paul Moore <paul@paul-moore.com>
Date:   Wed, 29 May 2019 11:29:05 -0400
Message-ID: <CAHC9VhR4fudQanvZGYWMvCf7k2CU3q7e7n1Pi7hzC3v_zpVEdw@mail.gmail.com>
Subject: Re: [PATCH ghak90 V6 02/10] audit: add container id
To:     Tycho Andersen <tycho@tycho.ws>
Cc:     Richard Guy Briggs <rgb@redhat.com>,
        containers@lists.linux-foundation.org, linux-api@vger.kernel.org,
        Linux-Audit Mailing List <linux-audit@redhat.com>,
        linux-fsdevel@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        netdev@vger.kernel.org, netfilter-devel@vger.kernel.org,
        sgrubb@redhat.com, omosnace@redhat.com, dhowells@redhat.com,
        simo@redhat.com, Eric Paris <eparis@parisplace.org>,
        Serge Hallyn <serge@hallyn.com>, ebiederm@xmission.com,
        nhorman@tuxdriver.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 29, 2019 at 10:57 AM Tycho Andersen <tycho@tycho.ws> wrote:
>
> On Mon, Apr 08, 2019 at 11:39:09PM -0400, Richard Guy Briggs wrote:
> > It is not permitted to unset the audit container identifier.
> > A child inherits its parent's audit container identifier.
>
> ...
>
> >  /**
> > + * audit_set_contid - set current task's audit contid
> > + * @contid: contid value
> > + *
> > + * Returns 0 on success, -EPERM on permission failure.
> > + *
> > + * Called (set) from fs/proc/base.c::proc_contid_write().
> > + */
> > +int audit_set_contid(struct task_struct *task, u64 contid)
> > +{
> > +     u64 oldcontid;
> > +     int rc = 0;
> > +     struct audit_buffer *ab;
> > +     uid_t uid;
> > +     struct tty_struct *tty;
> > +     char comm[sizeof(current->comm)];
> > +
> > +     task_lock(task);
> > +     /* Can't set if audit disabled */
> > +     if (!task->audit) {
> > +             task_unlock(task);
> > +             return -ENOPROTOOPT;
> > +     }
> > +     oldcontid = audit_get_contid(task);
> > +     read_lock(&tasklist_lock);
> > +     /* Don't allow the audit containerid to be unset */
> > +     if (!audit_contid_valid(contid))
> > +             rc = -EINVAL;
> > +     /* if we don't have caps, reject */
> > +     else if (!capable(CAP_AUDIT_CONTROL))
> > +             rc = -EPERM;
> > +     /* if task has children or is not single-threaded, deny */
> > +     else if (!list_empty(&task->children))
> > +             rc = -EBUSY;
> > +     else if (!(thread_group_leader(task) && thread_group_empty(task)))
> > +             rc = -EALREADY;
> > +     read_unlock(&tasklist_lock);
> > +     if (!rc)
> > +             task->audit->contid = contid;
> > +     task_unlock(task);
> > +
> > +     if (!audit_enabled)
> > +             return rc;
>
> ...but it is allowed to change it (assuming
> capable(CAP_AUDIT_CONTROL), of course)? Seems like this might be more
> immediately useful since we still live in the world of majority
> privileged containers if we didn't allow changing it, in addition to
> un-setting it.

The idea is that only container orchestrators should be able to
set/modify the audit container ID, and since setting the audit
container ID can have a significant effect on the records captured
(and their routing to multiple daemons when we get there) modifying
the audit container ID is akin to modifying the audit configuration
which is why it is gated by CAP_AUDIT_CONTROL.  The current thinking
is that you would only change the audit container ID from one
set/inherited value to another if you were nesting containers, in
which case the nested container orchestrator would need to be granted
CAP_AUDIT_CONTROL (which everyone to date seems to agree is a workable
compromise).  We did consider allowing for a chain of nested audit
container IDs, but the implications of doing so are significant
(implementation mess, runtime cost, etc.) so we are leaving that out
of this effort.

From a practical perspective, un-setting the audit container ID is
pretty much the same as changing it from one set value to another so
most of the above applies to that case as well.

-- 
paul moore
www.paul-moore.com
