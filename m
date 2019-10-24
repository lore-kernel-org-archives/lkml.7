Return-Path: <SRS0=Yun1=YR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B900DCA9EAF
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 09:02:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B9A920856
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 09:02:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="B/DRKA86"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392958AbfJXJC4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Oct 2019 05:02:56 -0400
Received: from mail-il1-f193.google.com ([209.85.166.193]:46831 "EHLO
        mail-il1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387741AbfJXJCz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Oct 2019 05:02:55 -0400
Received: by mail-il1-f193.google.com with SMTP id m16so15254213iln.13
        for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2019 02:02:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Shf6R99Mq/i6rKVdmQjchCTfPEMVnKeGQOrlMCCw8ng=;
        b=B/DRKA866HSovygatg9KkAg1y0TgfZdkYdE+6n9uttwiItcgZIboqxBPbgT/zvTU4g
         SYjSWdKnRhMH2okbMN2D6gHouUNMqa13oiXDPDnyVoML2szIYG0QeU+dSklzIk6hsTnM
         MDhzZ4YI/TmiQsKWi+tkrDaYBpKs6CvxvRmE8ikoKOfUOsMdveuzcmCzqskzRzrNEBM0
         rHHZDYEMKuZGtVSNoZ5MsRv7aZBgT+SDpjGWLUskWGiY/BqwbXvXGx0lm/gAPSUi4cO0
         W+3yi7qry+lVjlMD0qpqfbP/U6WCy4PeX39HGVlxMnECP1xdSO+0KXBr8NIh/geS/dDW
         ioXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Shf6R99Mq/i6rKVdmQjchCTfPEMVnKeGQOrlMCCw8ng=;
        b=ILDTqMLsBE0PoMlq9JWQriixgv5xt/Hy/xh80CEKxI9DO5rVlaitmAC68JgaH79j1i
         I9bqpoqap17gWIrnPR5OJn24ZUILymZ4miNvq6WV43HMTlMHU/+gsCjEE7+ddZhku87S
         G2wzu+/hK+ENTNfAcYuLHXT7I7Mof6JQ/M0OLTHuNhF57FcfFZrcbutYyPGjy5I+TndK
         0eiKjr82jg9WlreV665U032IKtNqM8jLgjLBYBUPsSYEp6DFsLo7NHFrHbxkQOa0ap8t
         PRwcZzSRYFyAh4tZpuB4VUGmnzjRdM8QHtlaQxbHITj9lp9h2CfiI/ZTMG7v6bJXauTM
         mVFA==
X-Gm-Message-State: APjAAAXZOsChToaF5DgO7pFtCBddQRiWIrgGX3Lri+Iyr9fgrlruBDUz
        p00K63B920gryi1tnq5A1ZyRodWSMhyz2B67hRXEjejtco+Suw==
X-Google-Smtp-Source: APXvYqyLEUaVof2ujdEi4OEB+nWP81XWCGM4dE5QJmOUS0gJDvfBOFu/gujfa9CKDGOOJYVz7WhVKs54g7CF+tZHVvM=
X-Received: by 2002:a92:aa48:: with SMTP id j69mr25244745ili.162.1571907774269;
 Thu, 24 Oct 2019 02:02:54 -0700 (PDT)
MIME-Version: 1.0
References: <20191022085924.92783-1-pumahsu@google.com> <20191023083221.GB8828@kuha.fi.intel.com>
 <644d890b-86e8-f05a-cd4c-32937d971a45@roeck-us.net> <20191023142900.GA15396@kuha.fi.intel.com>
 <20191023150126.GA16612@roeck-us.net> <20191023155757.GB15396@kuha.fi.intel.com>
In-Reply-To: <20191023155757.GB15396@kuha.fi.intel.com>
From:   Puma Hsu <pumahsu@google.com>
Date:   Thu, 24 Oct 2019 17:02:18 +0800
Message-ID: <CAGCq0LZGz04JCTEJXrBqs4ENybQih6zKWTacq9T9DKPNOQAfMw@mail.gmail.com>
Subject: Re: [PATCH V2] usb: typec: Add sysfs node to show connector orientation
To:     Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc:     Guenter Roeck <linux@roeck-us.net>,
        Greg KH <gregkh@linuxfoundation.org>,
        Badhri Jagan Sridharan <badhri@google.com>,
        Kyle Tso <kyletso@google.com>,
        Albert Wang <albertccwang@google.com>,
        Chien Kun Niu <rickyniu@google.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Yes, generally this might be purely informational or be a dynamically
debuggable
mechanism for end user as I mentioned in previous discussion
thread(https://lkml.org/lkml/2019/10/22/198).
Could I know if it is not suitable that we expose a file for
informational usage?


If everyone agreed above, about the definition of =E2=80=9Cunknown=E2=80=9D=
 and the condition
=E2=80=9Cdon=E2=80=99t know the orientation=E2=80=9D, what about adding add=
itional return value?
  1. For original =E2=80=9Cunknown=E2=80=9D, it is a generic unknown state =
which can
indicate no
      matter connector is disconnected, cannot specify which cc side
is configured(such as Ra-Ra),
      or even driver can not know the orientation.
  2. New additional value =E2=80=9Cunavailable=E2=80=9D, it can be used to
specifically explicate that
      driver can not know the orientation.
Take UCSI as example, it can use generic =E2=80=9Cunknown=E2=80=9D or =E2=
=80=9Cunavailable=E2=80=9D if
it wants.
But if it exposes =E2=80=9Cunavailable=E2=80=9D, then application in user s=
pace can
know that this attribute is not useful.



I summarize the proposal definition below:
 - unknown (generic unknown. driver don=E2=80=99t or can=E2=80=99t know the=
 polarity,
                      e.g. disconnected, both cc1 and cc2 are the same, )
 - normal (configured in cc1 side)
 - reversed (configured in cc2 side)
 - unavailable (not support the polarity detection)


Thanks in advance.
Puma Hsu


On Wed, Oct 23, 2019 at 11:58 PM Heikki Krogerus
<heikki.krogerus@linux.intel.com> wrote:
>
> On Wed, Oct 23, 2019 at 08:01:26AM -0700, Guenter Roeck wrote:
> > On Wed, Oct 23, 2019 at 05:29:00PM +0300, Heikki Krogerus wrote:
> > > On Wed, Oct 23, 2019 at 06:44:39AM -0700, Guenter Roeck wrote:
> > > > On 10/23/19 1:32 AM, Heikki Krogerus wrote:
> > > > > +Guenter
> > > > >
> > > > > On Tue, Oct 22, 2019 at 04:59:24PM +0800, Puma Hsu wrote:
> > > > > > Export the Type-C connector orientation so that user space
> > > > > > can get this information.
> > > > > >
> > > > > > Signed-off-by: Puma Hsu <pumahsu@google.com>
> > > > > > ---
> > > > > >   Documentation/ABI/testing/sysfs-class-typec | 11 +++++++++++
> > > > > >   drivers/usb/typec/class.c                   | 18 ++++++++++++=
++++++
> > > > > >   2 files changed, 29 insertions(+)
> > > > > >
> > > > > > diff --git a/Documentation/ABI/testing/sysfs-class-typec b/Docu=
mentation/ABI/testing/sysfs-class-typec
> > > > > > index d7647b258c3c..b22f71801671 100644
> > > > > > --- a/Documentation/ABI/testing/sysfs-class-typec
> > > > > > +++ b/Documentation/ABI/testing/sysfs-class-typec
> > > > > > @@ -108,6 +108,17 @@ Contact: Heikki Krogerus <heikki.krogerus@=
linux.intel.com>
> > > > > >   Description:
> > > > > >               Revision number of the supported USB Type-C speci=
fication.
> > > > > > +What:                /sys/class/typec/<port>/connector_orienta=
tion
> > > > > > +Date:                October 2019
> > > > > > +Contact:     Puma Hsu <pumahsu@google.com>
> > > > > > +Description:
> > > > > > +             Indicates which typec connector orientation is co=
nfigured now.
> > > > > > +             cc1 is defined as "normal" and cc2 is defined as =
"reversed".
> > > > > > +
> > > > > > +             Valid value:
> > > > > > +             - unknown (nothing configured)
> > > > >
> > > > > "unknown" means we do not know the orientation.
> > > > >
> > > > > > +             - normal (configured in cc1 side)
> > > > > > +             - reversed (configured in cc2 side)
> > > > >
> > > > > Guenter, do you think "connector_orientation" OK. I proposed it, =
but
> > > > > I'm now wondering if something like "polarity" would be better?
> > > > >
> > > >
> > > > Yes, or just "orientation". I don't see the value in the "connector=
_" prefix.
> > > > I also wonder if "unknown" is really correct. Is it really unknown,=
 or
> > > > does it mean that the port is disconnected ?
> > >
> > > Unknown means we don't know the orientation. We don't always have tha=
t
> > > information available to us. With UCSI we simply do not know it.
> > >
> > > I think this file needs to be hidden after all if we don't know the
> > > cable plug orientation.
> > >
> > Making the attribute appear and disappear may cause difficulties for
> > userspace.
> >
> > > How about empty string instead of "unknown"?
> > >
> > An empty string might also be challenging for userspace.
> >
> > "unknown" is fine if it is really unknown.
>
> That's what I was thinking, but I realised that since the value may be
> "unknown" even when the driver is able to tell the cable plug
> orientation, there is no way for the userspace to know is the driver
> able to supply the information or not. That is why I say the attribute
> has to be hidden in cases where the driver really does not know the
> orientation (like UCSI).
>
> I'm really not a big fan of hidden attribute files, as they do make
> things unpredictable for the userspace, but with information like
> this, either we simply do not provide it to the userspace at all -
> option that I'm all for if there is no real need for this - or we
> hide the file with drivers that can not supply the information.
>
> > With that in mind, I wonder what value that attribute has for
> > userspace, but presumably there must be some use case. I assume it
> > is purely informational.
>
> Puma actually already answered to this one:
> https://lkml.org/lkml/2019/10/22/198
>
> If I understood correctly, it would be purely informational. Puma,
> please correct me if I'm wrong!
>
> But if that is the case, and it is purely informational, then I don't
> think we should add this attribute at all.
>
>
> thanks,
>
> --
> heikki
