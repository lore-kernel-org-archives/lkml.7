Return-Path: <SRS0=WVJ0=YK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CB29FA3731
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Oct 2019 08:48:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1906C20663
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Oct 2019 08:48:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fwvF2pCK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408370AbfJQIs1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Oct 2019 04:48:27 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:43703 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2393312AbfJQIs1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Oct 2019 04:48:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1571302105;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=P23yKEodgmnfGUw9sfhLwiVnwWH7sPsG4YJ+YL5V5tM=;
        b=fwvF2pCKOpcVrn3xpwuRJX/NCFTTtSOmzmEOozk+/rsBhZK2Yb2TV9T+36inbKeSkRLyMp
        hUbC8ycLT7Jb4if8UrOhRR7CAIejb+SnL+jXlKgD4ARA2tJVMhgvFmlpqu4aicSuqwrWXb
        7zLwABIX18+oR3nKIOMDbcuMqHS7Amc=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-327-YFoeU68VNCuugA5ycGplQQ-1; Thu, 17 Oct 2019 04:48:23 -0400
Received: by mail-qt1-f199.google.com with SMTP id o34so1580732qtf.22
        for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2019 01:48:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ITrwUcZNhHdbR5/yJdBac5vGGHSYPWf4FBJkw33BU+U=;
        b=CZ+a47qm3CxgRF7oPMJjiddjMBGPwUTu/gM97CxxfdfCmCIAfZN9evZiDzdpsOdBuO
         fgXNR6CFj7QM11b2sNuoGSsoaXuYTtiF+zz+lIaK0jSHecTXAUdmSNeTQ/GSZcqhD4eH
         i5zYqyOc4yr9Z3YX9oW0OBdLFvKbCguZOfGx9vcncBWJvEmOPJj9By9DSCKkViZhiQjS
         2vrLSqQ1a4w6RltHy7iBSvkf93I504KZf0B3K+ysNtRcfzS/BBcPcmwPUjG0P7kmmE8n
         yxdphXIGKwrBipRXENvNUmJne3It7jUoBngzB0hvv5//TRGsRmd+w0Fi6vYpDEToGwEf
         MLGg==
X-Gm-Message-State: APjAAAWjBKlnnORcOxvoT2TaYnw6zs+XjZQZ1bcMU5oUotNGfTvLUDJ6
        OoU2mmV+2+KjAy6bwDPQD/xuTqy3LAqEKfGG4GjnLGu7lEh5xzJR5qZ9VnrYXP4LREZiWYcF9LW
        kAPhxq/8Yyy0gES8R1pfqkpO50veE+HnwgN8fA9yi
X-Received: by 2002:ac8:38bb:: with SMTP id f56mr2664260qtc.154.1571302101140;
        Thu, 17 Oct 2019 01:48:21 -0700 (PDT)
X-Google-Smtp-Source: APXvYqw6KHex7FZUFA1EICrnIh9zS+/BKcB7zS+GZg/tObmOEO5bLx2+4/yRRVT89C+jjp59lTtx3kazw3v1B4kfIfg=
X-Received: by 2002:ac8:38bb:: with SMTP id f56mr2664246qtc.154.1571302100911;
 Thu, 17 Oct 2019 01:48:20 -0700 (PDT)
MIME-Version: 1.0
References: <20191016182935.5616-1-andrew.smirnov@gmail.com>
 <20191016182935.5616-3-andrew.smirnov@gmail.com> <CAO-hwJ++YWtX29YefGzaEfCLDA=npZwUxDCkDzxALAmLLqv7FQ@mail.gmail.com>
 <CAHQ1cqHcm2z4dTJ-3kx-_e3_1mpz9x_AQ+GP_j-nqL=3Gm-AtQ@mail.gmail.com>
In-Reply-To: <CAHQ1cqHcm2z4dTJ-3kx-_e3_1mpz9x_AQ+GP_j-nqL=3Gm-AtQ@mail.gmail.com>
From:   Benjamin Tissoires <benjamin.tissoires@redhat.com>
Date:   Thu, 17 Oct 2019 10:48:09 +0200
Message-ID: <CAO-hwJJ8EJOtYYrsvh=bZKmMisRUADO-w6G7QRSGXe_-cdobUw@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] HID: logitech-hidpp: rework device validation
To:     Andrey Smirnov <andrew.smirnov@gmail.com>
Cc:     "open list:HID CORE LAYER" <linux-input@vger.kernel.org>,
        Sam Bazely <sambazley@fastmail.com>,
        Jiri Kosina <jikos@kernel.org>,
        Henrik Rydberg <rydberg@bitmath.org>,
        "Pierre-Loup A . Griffais" <pgriffais@valvesoftware.com>,
        Austin Palmer <austinp@valvesoftware.com>,
        lkml <linux-kernel@vger.kernel.org>,
        "3.8+" <stable@vger.kernel.org>
X-MC-Unique: YFoeU68VNCuugA5ycGplQQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 16, 2019 at 9:38 PM Andrey Smirnov <andrew.smirnov@gmail.com> w=
rote:
>
> On Wed, Oct 16, 2019 at 12:24 PM Benjamin Tissoires
> <benjamin.tissoires@redhat.com> wrote:
> >
> > Hi Andrey,
> >
> > On Wed, Oct 16, 2019 at 8:30 PM Andrey Smirnov <andrew.smirnov@gmail.co=
m> wrote:
> > >
> > > G920 device only advertises REPORT_ID_HIDPP_LONG and
> > > REPORT_ID_HIDPP_VERY_LONG in its HID report descriptor, so querying
> > > for REPORT_ID_HIDPP_SHORT with optional=3Dfalse will always fail and
> > > prevent G920 to be recognized as a valid HID++ device.
> > >
> > > To fix this and improve some other aspects, modify
> > > hidpp_validate_device() as follows:
> > >
> > >   - Inline the code of hidpp_validate_report() to simplify
> > >     distingushing between non-present and invalid report descriptors
> > >
> > >   - Drop the check for id >=3D HID_MAX_IDS || id < 0 since all of our
> > >     IDs are static and known to satisfy that at compile time
> > >
> > >   - Change the algorithms to check all possible report
> > >     types (including very long report) and deem the device as a valid
> > >     HID++ device if it supports at least one
> > >
> > >   - Treat invalid report length as a hard stop for the validation
> > >     algorithm, meaning that if any of the supported reports has
> > >     invalid length we assume the worst and treat the device as a
> > >     generic HID device.
> > >
> > >   - Fold initialization of hidpp->very_long_report_length into
> > >     hidpp_validate_device() since it already fetches very long report
> > >     length and validates its value
> > >
> > > Fixes: fe3ee1ec007b ("HID: logitech-hidpp: allow non HID++ devices to=
 be handled by this module")
> > > Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=3D204191
> > > Reported-by: Sam Bazely <sambazley@fastmail.com>
> > > Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
> > > Cc: Jiri Kosina <jikos@kernel.org>
> > > Cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>
> > > Cc: Henrik Rydberg <rydberg@bitmath.org>
> > > Cc: Pierre-Loup A. Griffais <pgriffais@valvesoftware.com>
> > > Cc: Austin Palmer <austinp@valvesoftware.com>
> > > Cc: linux-input@vger.kernel.org
> > > Cc: linux-kernel@vger.kernel.org
> > > Cc: stable@vger.kernel.org # 5.2+
> > > ---
> > >  drivers/hid/hid-logitech-hidpp.c | 54 ++++++++++++++++++------------=
--
> > >  1 file changed, 30 insertions(+), 24 deletions(-)
> > >
> > > diff --git a/drivers/hid/hid-logitech-hidpp.c b/drivers/hid/hid-logit=
ech-hidpp.c
> > > index 85911586b3b6..8c4be991f387 100644
> > > --- a/drivers/hid/hid-logitech-hidpp.c
> > > +++ b/drivers/hid/hid-logitech-hidpp.c
> > > @@ -3498,34 +3498,45 @@ static int hidpp_get_report_length(struct hid=
_device *hdev, int id)
> > >         return report->field[0]->report_count + 1;
> > >  }
> > >
> > > -static bool hidpp_validate_report(struct hid_device *hdev, int id,
> > > -                                 int expected_length, bool optional)
> > > +static bool hidpp_validate_device(struct hid_device *hdev)
> > >  {
> > > -       int report_length;
> > > +       struct hidpp_device *hidpp =3D hid_get_drvdata(hdev);
> > > +       int id, report_length, supported_reports =3D 0;
> > > +
> > > +       id =3D REPORT_ID_HIDPP_SHORT;
> > > +       report_length =3D hidpp_get_report_length(hdev, id);
> > > +       if (report_length) {
> > > +               if (report_length < HIDPP_REPORT_SHORT_LENGTH)
> > > +                       goto bad_device;
> > >
> > > -       if (id >=3D HID_MAX_IDS || id < 0) {
> > > -               hid_err(hdev, "invalid HID report id %u\n", id);
> > > -               return false;
> > > +               supported_reports++;
> > >         }
> > >
> > > +       id =3D REPORT_ID_HIDPP_LONG;
> > >         report_length =3D hidpp_get_report_length(hdev, id);
> > > -       if (!report_length)
> > > -               return optional;
> > > +       if (report_length) {
> > > +               if (report_length < HIDPP_REPORT_LONG_LENGTH)
> > > +                       goto bad_device;
> > >
> > > -       if (report_length < expected_length) {
> > > -               hid_warn(hdev, "not enough values in hidpp report %d\=
n", id);
> > > -               return false;
> > > +               supported_reports++;
> > >         }
> > >
> > > -       return true;
> > > -}
> > > +       id =3D REPORT_ID_HIDPP_VERY_LONG;
> > > +       report_length =3D hidpp_get_report_length(hdev, id);
> > > +       if (report_length) {
> > > +               if (report_length > HIDPP_REPORT_LONG_LENGTH &&
> > > +                   report_length < HIDPP_REPORT_VERY_LONG_MAX_LENGTH=
)
> >
> > Can you double check the conditions here?
> > It's late, but I think you inverted the tests as we expect the report
> > length to be between HIDPP_REPORT_LONG_LENGTH and
> > HIDPP_REPORT_VERY_LONG_MAX_LENGTH inclusive, while here this creates a
> > bad_device.
>
> Hmm, I think you are right. Not sure why I didn't catch it on G920
> since it support very long reports AFAIR. Will re-spin and double
> check in v3. Sorry about that.
>

Oh, the issue is that the very long HID++ reports on the G920 are
HIDPP_REPORT_VERY_LONG_MAX_LENGTH long, which means the test will fail
for those.

Cheers,
Benjamin

