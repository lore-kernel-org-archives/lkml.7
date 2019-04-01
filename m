Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14F6BC43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 22:54:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B00692086C
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 22:54:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RglM/hvO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726725AbfDAWyd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 18:54:33 -0400
Received: from mail-pf1-f179.google.com ([209.85.210.179]:45738 "EHLO
        mail-pf1-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725867AbfDAWyd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 18:54:33 -0400
Received: by mail-pf1-f179.google.com with SMTP id e24so5288378pfi.12
        for <linux-kernel@vger.kernel.org>; Mon, 01 Apr 2019 15:54:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LuS151iS9RNWVkeo+9npMzEV4wz2KWr1T3EXcdTvx2o=;
        b=RglM/hvOkdPNyCZUXj+Ua2dmpaiMDbGeAvtQ6gaPCJbO1nyVduyxVnL9kq0ulBd+RH
         qK0dGZfx7TzjIDE+u5gk8yLI5LD4P+Eq/ckSfLx/+VHP3X3MtKbZ8rQAY8HJgFo6fHja
         is0qFEIr7wirsT7/nzstsqHBiO9z31CdJyw3TquOEDPOP9ovHrQloCDACq4IxQJaSVOi
         R7hadOjOAfDB3pJ+uvPblISKPGeYW8gRtod9C9O6SpW8rJ3yYqwQYxi2SAyxv03r3l4G
         vi16wEvde73P36X35o/SsMKEc2V1dAOe1trxlfVU7gVwgJQliyexDWXZ5r5qDaaxA/3+
         MEOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LuS151iS9RNWVkeo+9npMzEV4wz2KWr1T3EXcdTvx2o=;
        b=NLTYPZPwQKkpgflD3tFcGU7mAPz53jhEe6m7qf5+FiCBB8lFb4FeMMFj7cx0IJowqD
         upjSrWWaAfflxwAy2MYhMkzUIbubQsmoYgWzmf2tsrqSIUqH+qLmiouHFUprIdgoQTj5
         P3f4ZF0OZXD4o4qkcEGWkWlVlbPzqHLuYGrwBLmhx1Vbh+4X4+duDvoHcITC324FAzfg
         N603g6ec6ir0zHENtUUWpTC2qc2hjmp6hhpWeW3yISQc4/5dEt2elrcN5wRiU0emqoxn
         gCm7FcbjDNmctsdZzhArA5e7P2oRFRjToE2EUD7liLGzjmMzLORGfIKcnfA2qbLWSpfi
         so/A==
X-Gm-Message-State: APjAAAXXdaGZDfWw4pv/CZyEshZhx7cCYSEkRpn1sfBppu6KFrVJA692
        PhZQhYnlEsYOHZM+ldzp7N9nwJMppg/9+Mbookbk402RR6w=
X-Google-Smtp-Source: APXvYqzm66pMOFrmkPpAGEwujO0XBJ7gDoiyqGAZkouuuOSI+uKbMCUYIoJr3+Mr57i3FxlgIycgzkDVquSo4xXGs98=
X-Received: by 2002:a63:e554:: with SMTP id z20mr59275789pgj.234.1554159271505;
 Mon, 01 Apr 2019 15:54:31 -0700 (PDT)
MIME-Version: 1.0
References: <CAMmhGqKc27W03roONYXhmwB0dtz5Z8nGoS2MLSsKJ3Zotv5-JA@mail.gmail.com>
 <20190329125258.2c6fe0cb@gandalf.local.home>
In-Reply-To: <20190329125258.2c6fe0cb@gandalf.local.home>
From:   Jason Behmer <jbehmer@google.com>
Date:   Mon, 1 Apr 2019 15:54:20 -0700
Message-ID: <CAMmhGqKPw1sxB_Qc+Z-MXZue+wtAQsQDDgUvjs4JQTVY8bR65g@mail.gmail.com>
Subject: Re: Nested events with zero deltas, can use absolute timestamps instead?
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     tom.zanussi@linux.intel.com, linux-kernel@vger.kernel.org
Content-Type: multipart/mixed; boundary="0000000000004df46305857fe7ce"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--0000000000004df46305857fe7ce
Content-Type: text/plain; charset="UTF-8"

On Fri, Mar 29, 2019 at 9:53 AM Steven Rostedt <rostedt@goodmis.org> wrote:
>
> On Fri, 29 Mar 2019 09:30:36 -0700
> Jason Behmer <jbehmer@google.com> wrote:
>
> > Hi Steven and Tom,
> > I recently ran into a problem with correlating timestamps across CPUs and
> > finally was able to track it down to the fact that nested events are given
> > zero deltas, and so are placed earlier in time than they actually occurred.
> >
> > I'm on an older version and wanted to check if this problem still exists on
> > head and it appears that it does, but I also ran into Tom's commits adding
> > the ability to use absolute timestamps instead of deltas.  It seems like
> > this option could fix the problem.
> >
> > It seems like ideally nested events could just always use these absolute
> > timestamps instead of zero deltas, as it appears the implementation of
> > absolute timestamps is flexible enough to have a mix of deltas and
> > absolutes in the stream of events.  A fix that would require less work
> > would be for me to just turn on absolute timestamps for my entire trace,
> > but I see that the file to do that isn't yet writable to support that.
> >
> > Before trying to do either of these things I wanted to run it by both of
> > you to see if there's something I'm missing here.  What do you think?
> >
>
> Yes this is an issue I need to fix. I have some ideas on how to handle
> this. I may need to go about looking into them again.
>
> It may be possible to add an option to have all nested events use the
> full timestamp as well.
>
> I'll have to think about this a bit more.
>
> -- Steve

The concurrency model is still a little bit unclear to me as I'm new
to this codebase.  So I'm having some trouble reasoning about what
operations are safe at one point on the ring buffer.    It seems like
we can't be preempted in general, just interrupts?  And the events for
the events emitted by interrupts will be fully processed before
getting back to the event pointed at by the commit pointer?  If this
is true I think the approach below (and prototyped in the attached
patch against head) might work and would love feedback.  If not, this
problem is way harder.

We detect nested events by checking our event pointer against the
commit pointer.  This is safe because we reserve our event space
atomically in the buffer, leading to an ordering of events we can
depend on.  But to add a TIME_STAMP event we need to reserve more
space before we even have an event pointer, so we need to know
something about the ordering of events before we've actually
atomically reserved ours.  We could check if the write pointer is set
to the commit pointer, and if it isn't we know we're a nested event.
But, someone could update the write pointer and/or commit pointer
between the time we check it and the time we atomically reserve our
space in the buffer.  However, I think maybe this is ok.

If we see that the write pointer is not equal to the commit pointer,
then we're in an interrupt, and the only thing that could update the
commit pointer is the original event emitting code that was
interrupted, which can't run again until we're finished.  And the only
thing that can update the write pointer is further interrupts of us,
which will advance the write pointer further away from commit, leaving
our decision to allocate a TIME_STAMP event as valid.

If we see that the write pointer is equal to the commit pointer, then
anything that interrupts us before we move the write pointer will see
that same state and will need to, before returning to us, commit their
event and set commit to their new write pointer, which will make our
decision valid once again.

There's a lot of assumptions in there that I'd love to be checked on
as I'm new to this code base.  For example I haven't read the read
path at all and have no idea if it interacts with this at all.

Thanks,
Jason

--0000000000004df46305857fe7ce
Content-Type: text/x-patch; charset="US-ASCII"; 
	name="0001-Adding-TIME_STAMP-events-to-all-nested-events.patch"
Content-Disposition: attachment; 
	filename="0001-Adding-TIME_STAMP-events-to-all-nested-events.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_jtyxkqjg0>
X-Attachment-Id: f_jtyxkqjg0

RnJvbSA0YmU0ZTc0MDMyMzM2NTIyNjkxYmYyZTc1MWU0MGFlNjc5Y2M4ODViIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBKYXNvbiBCZWhtZXIgPGpiZWhtZXJAZ29vZ2xlLmNvbT4KRGF0
ZTogTW9uLCAxIEFwciAyMDE5IDE1OjE1OjEzIC0wNzAwClN1YmplY3Q6IFtQQVRDSF0gQWRkaW5n
IFRJTUVfU1RBTVAgZXZlbnRzIHRvIGFsbCBuZXN0ZWQgZXZlbnRzLgoKLS0tCiBrZXJuZWwvdHJh
Y2UvcmluZ19idWZmZXIuYyB8IDk2ICsrKysrKysrKysrKysrKysrKysrKysrKysrKy0tLS0tLS0t
LS0tCiAxIGZpbGUgY2hhbmdlZCwgNzAgaW5zZXJ0aW9ucygrKSwgMjYgZGVsZXRpb25zKC0pCgpk
aWZmIC0tZ2l0IGEva2VybmVsL3RyYWNlL3JpbmdfYnVmZmVyLmMgYi9rZXJuZWwvdHJhY2Uvcmlu
Z19idWZmZXIuYwppbmRleCA0MWI2Zjk2ZTUzNjYuLjA3YTQwOGVkNzI0OCAxMDA2NDQKLS0tIGEv
a2VybmVsL3RyYWNlL3JpbmdfYnVmZmVyLmMKKysrIGIva2VybmVsL3RyYWNlL3JpbmdfYnVmZmVy
LmMKQEAgLTQyNSw3ICs0MjUsOCBAQCBzdHJ1Y3QgcmJfZXZlbnRfaW5mbyB7CiAJdTY0CQkJZGVs
dGE7CiAJdW5zaWduZWQgbG9uZwkJbGVuZ3RoOwogCXN0cnVjdCBidWZmZXJfcGFnZQkqdGFpbF9w
YWdlOwotCWludAkJCWFkZF90aW1lc3RhbXA7CisJYm9vbAkJCWFkZF90aW1lX2V4dGVuZDsKKwli
b29sCQkJYWRkX3RpbWVfc3RhbXA7CiB9OwogCiAvKgpAQCAtMjMxMywxNSArMjMxNCwxMiBAQCBy
Yl9tb3ZlX3RhaWwoc3RydWN0IHJpbmdfYnVmZmVyX3Blcl9jcHUgKmNwdV9idWZmZXIsCiAKIC8q
IFNsb3cgcGF0aCwgZG8gbm90IGlubGluZSAqLwogc3RhdGljIG5vaW5saW5lIHN0cnVjdCByaW5n
X2J1ZmZlcl9ldmVudCAqCi1yYl9hZGRfdGltZV9zdGFtcChzdHJ1Y3QgcmluZ19idWZmZXJfZXZl
bnQgKmV2ZW50LCB1NjQgZGVsdGEsIGJvb2wgYWJzKQorcmJfYWRkX3RpbWVfZXh0ZW5kKHN0cnVj
dCByaW5nX2J1ZmZlcl9ldmVudCAqZXZlbnQsIHU2NCBkZWx0YSkKIHsKLQlpZiAoYWJzKQotCQll
dmVudC0+dHlwZV9sZW4gPSBSSU5HQlVGX1RZUEVfVElNRV9TVEFNUDsKLQllbHNlCi0JCWV2ZW50
LT50eXBlX2xlbiA9IFJJTkdCVUZfVFlQRV9USU1FX0VYVEVORDsKKwlldmVudC0+dHlwZV9sZW4g
PSBSSU5HQlVGX1RZUEVfVElNRV9FWFRFTkQ7CiAKIAkvKiBOb3QgdGhlIGZpcnN0IGV2ZW50IG9u
IHRoZSBwYWdlLCBvciBub3QgZGVsdGE/ICovCi0JaWYgKGFicyB8fCByYl9ldmVudF9pbmRleChl
dmVudCkpIHsKKwlpZiAocmJfZXZlbnRfaW5kZXgoZXZlbnQpKSB7CiAJCWV2ZW50LT50aW1lX2Rl
bHRhID0gZGVsdGEgJiBUU19NQVNLOwogCQlldmVudC0+YXJyYXlbMF0gPSBkZWx0YSA+PiBUU19T
SElGVDsKIAl9IGVsc2UgewpAQCAtMjMzMyw2ICsyMzMxLDIxIEBAIHJiX2FkZF90aW1lX3N0YW1w
KHN0cnVjdCByaW5nX2J1ZmZlcl9ldmVudCAqZXZlbnQsIHU2NCBkZWx0YSwgYm9vbCBhYnMpCiAJ
cmV0dXJuIHNraXBfdGltZV9leHRlbmQoZXZlbnQpOwogfQogCisvKiBTbG93IHBhdGgsIGRvIG5v
dCBpbmxpbmUgKi8KK3N0YXRpYyBub2lubGluZSBzdHJ1Y3QgcmluZ19idWZmZXJfZXZlbnQgKgor
cmJfYWRkX3RpbWVfc3RhbXAoc3RydWN0IHJpbmdfYnVmZmVyX2V2ZW50ICpldmVudCwgdTY0IHRp
bWVzdGFtcCkKK3sKKwlldmVudC0+dHlwZV9sZW4gPSBSSU5HQlVGX1RZUEVfVElNRV9TVEFNUDsK
KyAgICAgICAgLyoKKyAgICAgICAgICogU3RvcmUgYSBmdWxsIHRpbWVzdGFtcCBpbiB0aGUgdGlt
ZV9kZWx0YSBmaWVsZCBhbmQgdGhlIGZpcnN0IGRhdGEKKyAgICAgICAgICogZWxlbWVudC4KKyAg
ICAgICAgICovCisJZXZlbnQtPnRpbWVfZGVsdGEgPSB0aW1lc3RhbXAgJiBUU19NQVNLOworCWV2
ZW50LT5hcnJheVswXSA9IHRpbWVzdGFtcCA+PiBUU19TSElGVDsKKworCXJldHVybiBza2lwX3Rp
bWVfZXh0ZW5kKGV2ZW50KTsKK30KKwogc3RhdGljIGlubGluZSBib29sIHJiX2V2ZW50X2lzX2Nv
bW1pdChzdHJ1Y3QgcmluZ19idWZmZXJfcGVyX2NwdSAqY3B1X2J1ZmZlciwKIAkJCQkgICAgIHN0
cnVjdCByaW5nX2J1ZmZlcl9ldmVudCAqZXZlbnQpOwogCkBAIC0yMzYwLDE1ICsyMzczLDE3IEBA
IHJiX3VwZGF0ZV9ldmVudChzdHJ1Y3QgcmluZ19idWZmZXJfcGVyX2NwdSAqY3B1X2J1ZmZlciwK
IAkJZGVsdGEgPSAwOwogCiAJLyoKLQkgKiBJZiB3ZSBuZWVkIHRvIGFkZCBhIHRpbWVzdGFtcCwg
dGhlbiB3ZQorCSAqIElmIHdlIG5lZWQgdG8gYWRkIGEgVElNRV9FWFRFTkQgb3IgVElNRV9TVEFN
UCwgdGhlbiB3ZQogCSAqIGFkZCBpdCB0byB0aGUgc3RhcnQgb2YgdGhlIHJlc2VydmVkIHNwYWNl
LgogCSAqLwotCWlmICh1bmxpa2VseShpbmZvLT5hZGRfdGltZXN0YW1wKSkgewotCQlib29sIGFi
cyA9IHJpbmdfYnVmZmVyX3RpbWVfc3RhbXBfYWJzKGNwdV9idWZmZXItPmJ1ZmZlcik7Ci0KLQkJ
ZXZlbnQgPSByYl9hZGRfdGltZV9zdGFtcChldmVudCwgaW5mby0+ZGVsdGEsIGFicyk7CisJaWYg
KHVubGlrZWx5KGluZm8tPmFkZF90aW1lX2V4dGVuZCkpIHsKKwkJZXZlbnQgPSByYl9hZGRfdGlt
ZV9leHRlbmQoZXZlbnQsIGluZm8tPmRlbHRhKTsKIAkJbGVuZ3RoIC09IFJCX0xFTl9USU1FX0VY
VEVORDsKIAkJZGVsdGEgPSAwOworCX0gZWxzZSBpZiAodW5saWtlbHkoaW5mby0+YWRkX3RpbWVf
c3RhbXApKSB7CisJCWV2ZW50ID0gcmJfYWRkX3RpbWVfc3RhbXAoZXZlbnQsIGluZm8tPmRlbHRh
KTsKKwkJbGVuZ3RoIC09IFJCX0xFTl9USU1FX1NUQU1QOworCQlkZWx0YSA9IDA7CiAJfQogCiAJ
ZXZlbnQtPnRpbWVfZGVsdGEgPSBkZWx0YTsKQEAgLTI1MjAsNiArMjUzNSwxNCBAQCByYl9zZXRf
Y29tbWl0X3RvX3dyaXRlKHN0cnVjdCByaW5nX2J1ZmZlcl9wZXJfY3B1ICpjcHVfYnVmZmVyKQog
CQlnb3RvIGFnYWluOwogfQogCitzdGF0aWMgX19hbHdheXNfaW5saW5lIGJvb2wKK3JiX2NvbW1p
dF9pc193cml0ZShzdHJ1Y3QgcmluZ19idWZmZXJfcGVyX2NwdSAqY3B1X2J1ZmZlcikKK3sKKyAg
cmV0dXJuIGNwdV9idWZmZXItPmNvbW1pdF9wYWdlID09IGNwdV9idWZmZXItPnRhaWxfcGFnZSAm
JgorICAgICAgcmJfY29tbWl0X2luZGV4KGNwdV9idWZmZXIpID09IHJiX3BhZ2Vfd3JpdGUoY3B1
X2J1ZmZlci0+Y29tbWl0X3BhZ2UpOworCit9CisKIHN0YXRpYyBfX2Fsd2F5c19pbmxpbmUgdm9p
ZCByYl9lbmRfY29tbWl0KHN0cnVjdCByaW5nX2J1ZmZlcl9wZXJfY3B1ICpjcHVfYnVmZmVyKQog
ewogCXVuc2lnbmVkIGxvbmcgY29tbWl0czsKQEAgLTI4MDUsMTkgKzI4MjgsMjMgQEAgRVhQT1JU
X1NZTUJPTF9HUEwocmluZ19idWZmZXJfdW5sb2NrX2NvbW1pdCk7CiAKIHN0YXRpYyBub2lubGlu
ZSB2b2lkCiByYl9oYW5kbGVfdGltZXN0YW1wKHN0cnVjdCByaW5nX2J1ZmZlcl9wZXJfY3B1ICpj
cHVfYnVmZmVyLAotCQkgICAgc3RydWN0IHJiX2V2ZW50X2luZm8gKmluZm8pCisJCSAgICBzdHJ1
Y3QgcmJfZXZlbnRfaW5mbyAqaW5mbywgaW50IGFicykKIHsKIAlXQVJOX09OQ0UoaW5mby0+ZGVs
dGEgPiAoMVVMTCA8PCA1OSksCi0JCSAgS0VSTl9XQVJOSU5HICJEZWx0YSB3YXkgdG9vIGJpZyEg
JWxsdSB0cz0lbGx1IHdyaXRlIHN0YW1wID0gJWxsdVxuJXMiLAorCQkgIEtFUk5fV0FSTklORyAi
RGVsdGEgd2F5IHRvbyBiaWchICVsbHUgdHM9JWxsdSB3cml0ZSBzdGFtcCA9ICVsbHUgYWJzPSVk
XG4lcyIsCiAJCSAgKHVuc2lnbmVkIGxvbmcgbG9uZylpbmZvLT5kZWx0YSwKIAkJICAodW5zaWdu
ZWQgbG9uZyBsb25nKWluZm8tPnRzLAogCQkgICh1bnNpZ25lZCBsb25nIGxvbmcpY3B1X2J1ZmZl
ci0+d3JpdGVfc3RhbXAsCisJCSAgYWJzLAogCQkgIHNjaGVkX2Nsb2NrX3N0YWJsZSgpID8gIiIg
OgogCQkgICJJZiB5b3UganVzdCBjYW1lIGZyb20gYSBzdXNwZW5kL3Jlc3VtZSxcbiIKIAkJICAi
cGxlYXNlIHN3aXRjaCB0byB0aGUgdHJhY2UgZ2xvYmFsIGNsb2NrOlxuIgogCQkgICIgIGVjaG8g
Z2xvYmFsID4gL3N5cy9rZXJuZWwvZGVidWcvdHJhY2luZy90cmFjZV9jbG9ja1xuIgogCQkgICJv
ciBhZGQgdHJhY2VfY2xvY2s9Z2xvYmFsIHRvIHRoZSBrZXJuZWwgY29tbWFuZCBsaW5lXG4iKTsK
LQlpbmZvLT5hZGRfdGltZXN0YW1wID0gMTsKKwlpZiAoYWJzKQorCQlpbmZvLT5hZGRfdGltZV9z
dGFtcCA9IHRydWU7CisJZWxzZQorCQlpbmZvLT5hZGRfdGltZV9leHRlbmQgPSB0cnVlOwogfQog
CiBzdGF0aWMgc3RydWN0IHJpbmdfYnVmZmVyX2V2ZW50ICoKQEAgLTI4MjgsMTMgKzI4NTUsMjAg
QEAgX19yYl9yZXNlcnZlX25leHQoc3RydWN0IHJpbmdfYnVmZmVyX3Blcl9jcHUgKmNwdV9idWZm
ZXIsCiAJc3RydWN0IGJ1ZmZlcl9wYWdlICp0YWlsX3BhZ2U7CiAJdW5zaWduZWQgbG9uZyB0YWls
LCB3cml0ZTsKIAotCS8qCi0JICogSWYgdGhlIHRpbWUgZGVsdGEgc2luY2UgdGhlIGxhc3QgZXZl
bnQgaXMgdG9vIGJpZyB0bwotCSAqIGhvbGQgaW4gdGhlIHRpbWUgZmllbGQgb2YgdGhlIGV2ZW50
LCB0aGVuIHdlIGFwcGVuZCBhCi0JICogVElNRSBFWFRFTkQgZXZlbnQgYWhlYWQgb2YgdGhlIGRh
dGEgZXZlbnQuCi0JICovCi0JaWYgKHVubGlrZWx5KGluZm8tPmFkZF90aW1lc3RhbXApKQorCWlm
ICh1bmxpa2VseShpbmZvLT5hZGRfdGltZV9leHRlbmQpKQorCQkvKgorCQkgKiBJZiB0aGUgdGlt
ZSBkZWx0YSBzaW5jZSB0aGUgbGFzdCBldmVudCBpcyB0b28gYmlnIHRvCisJCSAqIGhvbGQgaW4g
dGhlIHRpbWUgZmllbGQgb2YgdGhlIGV2ZW50LCB0aGVuIHdlIGFwcGVuZCBhCisJCSAqIFRJTUUg
RVhURU5EIGV2ZW50IGFoZWFkIG9mIHRoZSBkYXRhIGV2ZW50LgorCQkgKi8KIAkJaW5mby0+bGVu
Z3RoICs9IFJCX0xFTl9USU1FX0VYVEVORDsKKwllbHNlIGlmICh1bmxpa2VseShpbmZvLT5hZGRf
dGltZV9zdGFtcCkpCisJCS8qCisJCSAqIElmIHVzaW5nIGFic29sdXRlIHRpbWUgc3RhbXBzIGZv
ciB0aGlzIGV2ZW50LCB0aGVuIHdlIGFwcGVuZAorICAgICAgICAgICAgICAgICAqIGEgVElNRSBT
VEFNUCBldmVudCBhaGVhZCBvZiB0aGUgZGF0YSBldmVudCB0byBmaXQgdGhlIGZ1bGwKKyAgICAg
ICAgICAgICAgICAgKiB0aW1lc3RhbXAuCisJCSAqLworCQlpbmZvLT5sZW5ndGggKz0gUkJfTEVO
X1RJTUVfU1RBTVA7CiAKIAkvKiBEb24ndCBsZXQgdGhlIGNvbXBpbGVyIHBsYXkgZ2FtZXMgd2l0
aCBjcHVfYnVmZmVyLT50YWlsX3BhZ2UgKi8KIAl0YWlsX3BhZ2UgPSBpbmZvLT50YWlsX3BhZ2Ug
PSBSRUFEX09OQ0UoY3B1X2J1ZmZlci0+dGFpbF9wYWdlKTsKQEAgLTI4NDgsNyArMjg4Miw3IEBA
IF9fcmJfcmVzZXJ2ZV9uZXh0KHN0cnVjdCByaW5nX2J1ZmZlcl9wZXJfY3B1ICpjcHVfYnVmZmVy
LAogCSAqIElmIHRoaXMgaXMgdGhlIGZpcnN0IGNvbW1pdCBvbiB0aGUgcGFnZSwgdGhlbiBpdCBo
YXMgdGhlIHNhbWUKIAkgKiB0aW1lc3RhbXAgYXMgdGhlIHBhZ2UgaXRzZWxmLgogCSAqLwotCWlm
ICghdGFpbCAmJiAhcmluZ19idWZmZXJfdGltZV9zdGFtcF9hYnMoY3B1X2J1ZmZlci0+YnVmZmVy
KSkKKwlpZiAoIXRhaWwgJiYgIXVubGlrZWx5KGluZm8tPmFkZF90aW1lX3N0YW1wKSkKIAkJaW5m
by0+ZGVsdGEgPSAwOwogCiAJLyogU2VlIGlmIHdlIHNob3QgcGFzcyB0aGUgZW5kIG9mIHRoaXMg
YnVmZmVyIHBhZ2UgKi8KQEAgLTI5MDQsNyArMjkzOCw4IEBAIHJiX3Jlc2VydmVfbmV4dF9ldmVu
dChzdHJ1Y3QgcmluZ19idWZmZXIgKmJ1ZmZlciwKIAogCWluZm8ubGVuZ3RoID0gcmJfY2FsY3Vs
YXRlX2V2ZW50X2xlbmd0aChsZW5ndGgpOwogIGFnYWluOgotCWluZm8uYWRkX3RpbWVzdGFtcCA9
IDA7CisJaW5mby5hZGRfdGltZV9leHRlbmQgPSBmYWxzZTsKKwlpbmZvLmFkZF90aW1lX3N0YW1w
ID0gZmFsc2U7CiAJaW5mby5kZWx0YSA9IDA7CiAKIAkvKgpAQCAtMjkyNywxOSArMjk2MiwyOCBA
QCByYl9yZXNlcnZlX25leHRfZXZlbnQoc3RydWN0IHJpbmdfYnVmZmVyICpidWZmZXIsCiAKIAlp
ZiAocmluZ19idWZmZXJfdGltZV9zdGFtcF9hYnMoYnVmZmVyKSkgewogCQlpbmZvLmRlbHRhID0g
aW5mby50czsKLQkJcmJfaGFuZGxlX3RpbWVzdGFtcChjcHVfYnVmZmVyLCAmaW5mbyk7CisJCXJi
X2hhbmRsZV90aW1lc3RhbXAoY3B1X2J1ZmZlciwgJmluZm8sIHRydWUpOworCX0gZWxzZSBpZiAo
IXJiX2NvbW1pdF9pc193cml0ZShjcHVfYnVmZmVyKSkgeworCQkvKgorCQkgKiBVc2UgYWJzb2x1
dGUgdGltZXN0YW1wcyBmb3IgbmVzdGVkIGV2ZW50cywgd2hlcmUgd2UgY2FuJ3QKKwkJICogY29t
cHV0ZSBhIGRlbHRhLgorCQkgKi8KKwkJaW5mby5kZWx0YSA9IGluZm8udHM7CisJCXJiX2hhbmRs
ZV90aW1lc3RhbXAoY3B1X2J1ZmZlciwgJmluZm8sIHRydWUpOwogCX0gZWxzZSAvKiBEaWQgdGhl
IHdyaXRlIHN0YW1wIGdldCB1cGRhdGVkIGFscmVhZHk/ICovCiAJCWlmIChsaWtlbHkoaW5mby50
cyA+PSBjcHVfYnVmZmVyLT53cml0ZV9zdGFtcCkpIHsKIAkJaW5mby5kZWx0YSA9IGRpZmY7CiAJ
CWlmICh1bmxpa2VseSh0ZXN0X3RpbWVfc3RhbXAoaW5mby5kZWx0YSkpKQotCQkJcmJfaGFuZGxl
X3RpbWVzdGFtcChjcHVfYnVmZmVyLCAmaW5mbyk7CisJCQlyYl9oYW5kbGVfdGltZXN0YW1wKGNw
dV9idWZmZXIsICZpbmZvLCBmYWxzZSk7CiAJfQogCiAJZXZlbnQgPSBfX3JiX3Jlc2VydmVfbmV4
dChjcHVfYnVmZmVyLCAmaW5mbyk7CiAKIAlpZiAodW5saWtlbHkoUFRSX0VSUihldmVudCkgPT0g
LUVBR0FJTikpIHsKLQkJaWYgKGluZm8uYWRkX3RpbWVzdGFtcCkKKwkJaWYgKGluZm8uYWRkX3Rp
bWVfZXh0ZW5kKQogCQkJaW5mby5sZW5ndGggLT0gUkJfTEVOX1RJTUVfRVhURU5EOworCQllbHNl
IGlmIChpbmZvLmFkZF90aW1lX3N0YW1wKQorCQkJaW5mby5sZW5ndGggLT0gUkJfTEVOX1RJTUVf
U1RBTVA7CiAJCWdvdG8gYWdhaW47CiAJfQogCi0tIAoyLjIxLjAuMzkyLmdmOGY2Nzg3MTU5ZS1n
b29nCgo=
--0000000000004df46305857fe7ce--
