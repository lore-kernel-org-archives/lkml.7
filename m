Return-Path: <SRS0=2+op=Y5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63AF5C00F20
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Nov 2019 10:17:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2BD402190F
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Nov 2019 10:17:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paloaltonetworks.com header.i=@paloaltonetworks.com header.b="Z8ncsy95";
	dkim=pass (2048-bit key) header.d=paloaltonetworks-com.20150623.gappssmtp.com header.i=@paloaltonetworks-com.20150623.gappssmtp.com header.b="hQFaU4rF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388472AbfKEKRF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Nov 2019 05:17:05 -0500
Received: from mx0b-00169c01.pphosted.com ([67.231.156.123]:4462 "EHLO
        mx0b-00169c01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730699AbfKEKRD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Nov 2019 05:17:03 -0500
X-Greylist: delayed 4406 seconds by postgrey-1.27 at vger.kernel.org; Tue, 05 Nov 2019 05:17:02 EST
Received: from pps.filterd (m0048189.ppops.net [127.0.0.1])
        by mx0b-00169c01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xA592ukw019422
        for <linux-kernel@vger.kernel.org>; Tue, 5 Nov 2019 01:03:35 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=paloaltonetworks.com;
 h=mime-version : references : in-reply-to : from : date : message-id :
 subject : to : cc : content-type; s=PPS12012017;
 bh=ciVbnO2cg9JjrtDZ/6z1+43k0ZLqoEoEaJq43htPmN0=;
 b=Z8ncsy95ZiiSi4Fm1gSdvEcybXA1nWL1eFqxDiVGtz5lHYb4+bkJc0wEdqYyt3nOGfK/
 HMlUSuJb3xv/YOqKm+B5/9fPz2ByH/uN8vOSsiEv1wtU/9XgswQRg9NmAI8m3ZXIE69/
 1V2gM8hagnXCsnDgoYyOTAWYRzp7RNzx8y8DE/J7jgAekCS3wDaEk0iSxsWd3L5P2ujN
 4kp0H1F5UOszRZiDO/2rf1IiK1eRb/HgXn2s4bFFMMXEzVndtQ+FALOP61NiygRKclYw
 3Q+xikIa9++qeD3DmowOVTiFokfeYU0nu0N5/WGVDX/97scz88gHYBGizDHiIcaBZ320 BA== 
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
        by mx0b-00169c01.pphosted.com with ESMTP id 2w19a475pu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Tue, 05 Nov 2019 01:03:35 -0800
Received: by mail-qk1-f199.google.com with SMTP id a13so20538582qkc.17
        for <linux-kernel@vger.kernel.org>; Tue, 05 Nov 2019 01:03:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paloaltonetworks-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ciVbnO2cg9JjrtDZ/6z1+43k0ZLqoEoEaJq43htPmN0=;
        b=hQFaU4rFn7B7CKp4ERAv8NP9wHzexANCDFXwBtyHGwFJno48pBVJBchDnroMN/5Viw
         Xjdwt2mx82f6JTwMjd3BOvK6Mvds/RddNwtouJTVdjvyc4uiGrTeIhIxekw/kRohfW8Z
         zTROp533xmw6GwekT7aA+h0KA5NnEPJu2oUoYsYFQUBbjp78dNvv5CHPFccQMyBhpLJh
         oIoOGxYWB9dUM3iJI0q8MfVhx+/pfCOU6/xsVgS95lSKpup6mJpTVl+whetGmH+dSlD3
         IPrcjCKdiodUK2LMgLj45IuGmqbs6GziJjqRib708uXNhV858zGgPU4GgnOpB9Y4jQ89
         XcPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ciVbnO2cg9JjrtDZ/6z1+43k0ZLqoEoEaJq43htPmN0=;
        b=j8jlOvp3qGftrouNOs/kFzUlXmSXklnx//OTBOZSUvRalgHj+wOwGpbYeeQJprWx+e
         E7gm5B9FawGLgm7oMjk3LF2hgMMeP9JisRPJl6FOCMac1g7oYmRaApQgYzH6Vtbzf0cO
         cMKsJe6P3b3ue34dgbY8xoZd1K/wUL8kbahwWYcW/lr33Kjz3eI+OfKv5b/ixgwnk8Dl
         HWJ82x55gcfbSOhkr62Kg2d5E1Ssrr53V/ZtUTIFskmZ71rhgbGs8XyFfh8Xl+a/U5wW
         RoAc4z03cPeMPvKPlaw3qYxgQkzKdL7y4ekpXVOKLDzLQYXDEMwqIgZrzbbJZHAldbai
         Yzxg==
X-Gm-Message-State: APjAAAUNzZiTJwYla9HwaLFoDnFqVJDjRLQ2XvBR6PIm9Wda2zvERdwL
        dJyu1kSbyC3PeB0pZpIpQwDhyBQTrC6nwZo68klojMYN3nVQtr+J+KJheJ4cPDeJ5FDy0hPj9eZ
        cDFvAUCeaCA7lTcGXsL1C75CU2xuzybgEXI59X+VW
X-Received: by 2002:a37:a64d:: with SMTP id p74mr22819113qke.285.1572944614614;
        Tue, 05 Nov 2019 01:03:34 -0800 (PST)
X-Google-Smtp-Source: APXvYqyQKgxpE+8b3mHr4DIZUzg6j8s3l5D35OTWQQAu292nkpDz3GQutihl1I/sdDL9sqjMO+keuy8HW8iFagzvq/4=
X-Received: by 2002:a37:a64d:: with SMTP id p74mr22819096qke.285.1572944614238;
 Tue, 05 Nov 2019 01:03:34 -0800 (PST)
MIME-Version: 1.0
References: <CAM6JnLeEnvjjQPyLeh+8dt5wGNud_vks5k_eXJZy2T1H7ao=hQ@mail.gmail.com>
 <20191104152428.GA2252441@kroah.com> <nycvar.YSQ.7.76.1911041648280.30289@knanqh.ubzr>
 <CAM6JnLdrzCPOYyfTdmriFo7cRaGM4p2OEPd_0MHa3_WemamffA@mail.gmail.com>
 <nycvar.YSQ.7.76.1911041928030.30289@knanqh.ubzr> <c30fc539-68a8-65d7-226c-6f8e6fd8bdfb@suse.com>
In-Reply-To: <c30fc539-68a8-65d7-226c-6f8e6fd8bdfb@suse.com>
From:   Or Cohen <orcohen@paloaltonetworks.com>
Date:   Tue, 5 Nov 2019 01:03:23 -0800
Message-ID: <CAM6JnLe88xf8hO0F=_Ni+irNt40+987tHmz9ZjppgxhnMnLxpw@mail.gmail.com>
Subject: Re: Bug report - slab-out-of-bounds in vcs_scr_readw
To:     Jiri Slaby <jslaby@suse.com>
Cc:     Nicolas Pitre <nico@fluxnic.net>,
        Greg KH <gregkh@linuxfoundation.org>, textshell@uchuujin.de,
        Daniel Vetter <daniel.vetter@ffwll.ch>, sam@ravnborg.org,
        mpatocka@redhat.com, ghalat@redhat.com,
        linux-kernel@vger.kernel.org, jwilk@jwilk.net,
        Nadav Markus <nmarkus@paloaltonetworks.com>,
        syzkaller@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,1.0.8
 definitions=2019-11-05_02:2019-11-04,2019-11-05 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_spam_notspam policy=outbound_spam score=0 impostorscore=0
 clxscore=1015 bulkscore=0 spamscore=0 priorityscore=1501 malwarescore=0
 suspectscore=1 lowpriorityscore=0 mlxlogscore=999 mlxscore=0 adultscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1908290000 definitions=main-1911050078
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

@Nicolas Pitre  - I agree with you, "vcs_size" may return a negative
error code, so the patch is correct but as @jslaby@suse.com  said it
won't fix the issue.
In my debugging session, "vcs_size" returns a positive integer ( 8000
decimal ) and the bug still triggers.

Maybe it's related to the following logic in "vcs_size"? ( not sure
about that.. )

221        if (use_attributes(inode)) {
222                if (use_unicode(inode))
223                        return -EOPNOTSUPP;
224                size = 2*size + HEADER_SIZE;
225       } else if (use_unicode(inode))
226               size *= 4;
227        return size;

Why in the case of "use_unicode(inode)" size is multiplied by 4 and
not 2?  ( as we can see in line 224 )





On Mon, Nov 4, 2019 at 10:54 PM Jiri Slaby <jslaby@suse.com> wrote:
>
> On 04. 11. 19, 19:33, Nicolas Pitre wrote:
> > On Mon, 4 Nov 2019, Or Cohen wrote:
> >
> >> @gregkh@linuxfoundation.org @nico@fluxnic.net  - Thanks for the quick response.
> >> @gregkh@linuxfoundation.org  - Regarding your question, I don't think
> >> the 1 byte buffer is related to the problem. (  it's just was there in
> >> the initial reproducer the fuzzer created, and I forgot to remove it
> >> while reducing code from the reproducer ).
> >
> > I think I know what the problem is. I have no time to test it though.
> >
> > Please try this (untested) patch. Also please try running the same test
> > code but with vcsa6 in addition to vcsu6 to be sure.
> >
> > ---------- >8
> > Subject: [PATCH] vcs: add missing validation on vcs_size() returned value
> >
> > One usage instance didn't account for the fact that vcs_size() may
> > return a negative error code.
> >
> > Signed-off-by: Nicolas Pitre <npitre@baylibre.com>
> >
> > diff --git a/drivers/tty/vt/vc_screen.c b/drivers/tty/vt/vc_screen.c
> > index 1f042346e7..fa07d79027 100644
> > --- a/drivers/tty/vt/vc_screen.c
> > +++ b/drivers/tty/vt/vc_screen.c
> > @@ -474,6 +474,10 @@ vcs_write(struct file *file, const char __user *buf, size_t count, loff_t *ppos)
> >               goto unlock_out;
> >
> >       size = vcs_size(inode);
> > +     if (size < 0) {
> > +             ret = size;
> > +             goto unlock_out;
> > +     }
> >       ret = -EINVAL;
> >       if (pos < 0 || pos > size)
> >               goto unlock_out;
>
> pos must be >= 0, so "pos > size" would catch this case as a side
> effect, or am I missing something? That being said, the patch is
> correct, but won't fix the issue IMO.
>
> thanks,
> --
> js
> suse labs
