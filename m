Return-Path: <SRS0=c662=XX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51E77C4360C
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Sep 2019 08:18:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1BB472082F
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Sep 2019 08:18:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1569658692;
	bh=jy8euhX3G218+m+Oi8HJDrJGQREGWJEf84fcsCuNbCA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=fOjjDcJ07AcInyLoV/X6bILE4wHDDXuwJfM70DgKL2522HG5cQmlV4KGYhm9zDwkr
	 CJlM06fGrtKxeuzCBJjzcgqbYLeVnA92gMnnRFMcfd+JBtKs1Sz2lynXO3HhhJHXmY
	 j8P3KePBGYj0H41XdzRtehHjweW5qdBxe/r5iH5c=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726892AbfI1IRv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 28 Sep 2019 04:17:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:47994 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725897AbfI1IRu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Sep 2019 04:17:50 -0400
Received: from devnote2 (unknown [12.157.10.118])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AF70B20815;
        Sat, 28 Sep 2019 08:17:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1569658669;
        bh=jy8euhX3G218+m+Oi8HJDrJGQREGWJEf84fcsCuNbCA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=uQfesz0BAP58IBZrlA8S9ovWcCmeZrhuMX3vbos8DyVQYKf9BuzKnXDPFNeG1A9W0
         1soG1f0ZQn7cfVGkfFdezKTzo6RnicFYd6lvlPdy/lbYPUjV/ofdWEKAXWQKSm7YW4
         FKjm6BxiN2kaX04HZ3JoxCbbna+zWP2v+Rkfl388=
Date:   Sat, 28 Sep 2019 01:17:48 -0700
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Srikar Dronamraju <srikar@linux.vnet.ibm.com>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Naveen Rao <naveen.n.rao@linux.vnet.ibm.com>,
        Ravi Bangoria <ravi.bangoria@linux.ibm.com>
Subject: Re: [PATCH] tracing/probe: Test nr_args match in looking for same
 probe events
Message-Id: <20190928011748.599255f6ffc9a4831e1efd2c@kernel.org>
In-Reply-To: <20190927131458.GA19008@linux.vnet.ibm.com>
References: <20190927055035.4c3abae9@oasis.local.home>
        <20190927131458.GA19008@linux.vnet.ibm.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="Multipart=_Sat__28_Sep_2019_01_17_48_-0700_1/TJYCw71cUunfOk"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.

--Multipart=_Sat__28_Sep_2019_01_17_48_-0700_1/TJYCw71cUunfOk
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Hi Sriker and Steve,

Sorry for later, I was in a conference.

On Fri, 27 Sep 2019 19:08:53 +0530
Srikar Dronamraju <srikar@linux.vnet.ibm.com> wrote:

> <SNIP>
> 
> > The cause was that the args array to compare between two probe events only
> > looked at one of the probe events size. If the other one had a smaller
> > number of args, it would read out of bounds memory.
> > 
> 
> I thought trace_probe_compare_arg_type() should have caught this. But looks
> like there is one case it misses. 
> 
> Currently trace_probe_compare_arg_type() is okay if the newer probe has
> lesser or equal arguments than the older probe. For all other cases, it
> seems to error out. In this case, we must be hitting where the newer probe
> has lesser arguments than older probe.
> 
> 
> > Fixes: fe60b0ce8e733 ("tracing/probe: Reject exactly same probe event")
> > Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
> > ---
> >  kernel/trace/trace_kprobe.c | 2 ++
> >  kernel/trace/trace_uprobe.c | 2 ++
> >  2 files changed, 4 insertions(+)
> > 
> > diff --git a/kernel/trace/trace_kprobe.c b/kernel/trace/trace_kprobe.c
> > index 402dc3ce88d3..d2543a403f25 100644
> > --- a/kernel/trace/trace_kprobe.c
> > +++ b/kernel/trace/trace_kprobe.c
> > @@ -537,6 +537,8 @@ static bool trace_kprobe_has_same_kprobe(struct trace_kprobe *orig,
> > 
> >  	list_for_each_entry(pos, &tpe->probes, list) {
> >  		orig = container_of(pos, struct trace_kprobe, tp);
> > +		if (orig->tp.nr_args != comp->tp.nr_args)
> > +			continue;
> 
> This has a side-effect where the newer probe has same argument commands, we
> still end up appending the probe.
> 
> Lets says we already have a probe with 2 arguments, the newer probe has only
> the first argument but same fetch command, we should have erred out.
> No?

Correct.

> 
> 
> >  		if (strcmp(trace_kprobe_symbol(orig),
> >  			   trace_kprobe_symbol(comp)) ||
> >  		    trace_kprobe_offset(orig) != trace_kprobe_offset(comp))
> > diff --git a/kernel/trace/trace_uprobe.c b/kernel/trace/trace_uprobe.c
> > index dd884341f5c5..11bcafdc93e2 100644
> > --- a/kernel/trace/trace_uprobe.c
> > +++ b/kernel/trace/trace_uprobe.c
> > @@ -420,6 +420,8 @@ static bool trace_uprobe_has_same_uprobe(struct trace_uprobe *orig,
> > 
> >  	list_for_each_entry(pos, &tpe->probes, list) {
> >  		orig = container_of(pos, struct trace_uprobe, tp);
> > +		if (orig->tp.nr_args != comp->tp.nr_args)
> > +			continue;
> >  		if (comp_inode != d_real_inode(orig->path.dentry) ||
> >  		    comp->offset != orig->offset)
> >  			continue;
> 
> How about something like this?

Thank you for pointing it out. But from what I intended, this is caused by
a bug in trace_probe_compare_arg_type() or it's caller.

                /*
                 * trace_probe_compare_arg_type() ensured that nr_args and
                 * each argument name and type are same. Let's compare comm.
                 */

If we found that 2 probes have different number of argument should not be
folded at all.
Also, we have to adjust error log position. Attached patch will fix those
errors correctly as bellow.

/sys/kernel/debug/tracing # echo p:myevent kernel_read %ax %bx >> kprobe_events
/sys/kernel/debug/tracing # echo p:myevent kernel_read %ax %bx >> kprobe_events
sh: write error: File exists
/sys/kernel/debug/tracing # echo p:myevent kernel_read %ax >> kprobe_events
sh: write error: File exists
/sys/kernel/debug/tracing # echo p:myevent kernel_read %ax %bx %cx >> kprobe_eve
nts
sh: write error: File exists
/sys/kernel/debug/tracing # cat error_log 
[   15.917727] trace_kprobe: error: There is already the exact same probe event
  Command: p:myevent kernel_read %ax %bx
           ^
[   24.890638] trace_kprobe: error: Argument type or name is different from existing probe
  Command: p:myevent kernel_read %ax
                                     ^
[   31.480521] trace_kprobe: error: Argument type or name is different from existing probe
  Command: p:myevent kernel_read %ax %bx %cx
                                         ^

Thank you,

-- 
Masami Hiramatsu

--Multipart=_Sat__28_Sep_2019_01_17_48_-0700_1/TJYCw71cUunfOk
Content-Type: application/octet-stream;
 name="tracing-probe-fix-to-check-the"
Content-Disposition: attachment;
 filename="tracing-probe-fix-to-check-the"
Content-Transfer-Encoding: base64

dHJhY2luZy9wcm9iZTogRml4IHRvIGNoZWNrIHRoZSBkaWZmZXJlbmNlIG9mIG5yX2FyZ3MgYmVm
b3JlIGFkZGluZyBwcm9iZQoKRnJvbTogTWFzYW1pIEhpcmFtYXRzdSA8bWhpcmFtYXRAa2VybmVs
Lm9yZz4KCkZpeCB0byBjaGVjayB0aGUgZGlmZmVyZW5jZSBvZiBucl9hcmdzIGJlZm9yZSBhZGRp
bmcgcHJvYmUKb24gZXhpc3RpbmcgcHJvYmVzLiBUaGlzIGFsc28gbWF5IHNldCB0aGUgZXJyb3Ig
bG9nIGluZGV4CmJpZ2dlciB0aGFuIHRoZSBudW1iZXIgb2YgY29tbWFuZCBwYXJhbWV0ZXJzLiBJ
biB0aGF0IGNhc2UKaXQgc2V0cyB0aGUgZXJyb3IgcG9zaXRpb24gaXMgbmV4dCB0byB0aGUgbGFz
dCBwYXJhbWV0ZXIuCgpTaWduZWQtb2ZmLWJ5OiBNYXNhbWkgSGlyYW1hdHN1IDxtaGlyYW1hdEBr
ZXJuZWwub3JnPgotLS0KIGtlcm5lbC90cmFjZS90cmFjZV9wcm9iZS5jIHwgICAxNiArKysrKysr
KysrKysrKysrCiAxIGZpbGUgY2hhbmdlZCwgMTYgaW5zZXJ0aW9ucygrKQoKZGlmZiAtLWdpdCBh
L2tlcm5lbC90cmFjZS90cmFjZV9wcm9iZS5jIGIva2VybmVsL3RyYWNlL3RyYWNlX3Byb2JlLmMK
aW5kZXggYmFmNThhMzYxMmMwLi45MDViMTBhZjVkNWMgMTAwNjQ0Ci0tLSBhL2tlcm5lbC90cmFj
ZS90cmFjZV9wcm9iZS5jCisrKyBiL2tlcm5lbC90cmFjZS90cmFjZV9wcm9iZS5jCkBAIC0xNzgs
NiArMTc4LDE2IEBAIHZvaWQgX190cmFjZV9wcm9iZV9sb2dfZXJyKGludCBvZmZzZXQsIGludCBl
cnJfdHlwZSkKIAlpZiAoIWNvbW1hbmQpCiAJCXJldHVybjsKIAorCWlmICh0cmFjZV9wcm9iZV9s
b2cuaW5kZXggPj0gdHJhY2VfcHJvYmVfbG9nLmFyZ2MpIHsKKwkJLyoqCisJCSAqIFNldCB0aGUg
ZXJyb3IgcG9zaXRpb24gaXMgbmV4dCB0byB0aGUgbGFzdCBhcmcgKyBzcGFjZS4KKwkJICogTm90
ZSB0aGF0IGxlbiBpbmNsdWRlcyB0aGUgdGVybWluYWwgbnVsbCBhbmQgdGhlIGN1cnNvcgorCQkg
KiBhcHBhZXJzIGF0IHBvcyArIDEuCisJCSAqLworCQlwb3MgPSBsZW47CisJCW9mZnNldCA9IDA7
CisJfQorCiAJLyogQW5kIG1ha2UgYSBjb21tYW5kIHN0cmluZyBmcm9tIGFyZ3YgYXJyYXkgKi8K
IAlwID0gY29tbWFuZDsKIAlmb3IgKGkgPSAwOyBpIDwgdHJhY2VfcHJvYmVfbG9nLmFyZ2M7IGkr
KykgewpAQCAtMTA4NCw2ICsxMDk0LDEyIEBAIGludCB0cmFjZV9wcm9iZV9jb21wYXJlX2FyZ190
eXBlKHN0cnVjdCB0cmFjZV9wcm9iZSAqYSwgc3RydWN0IHRyYWNlX3Byb2JlICpiKQogewogCWlu
dCBpOwogCisJLyogSW4gY2FzZSBvZiBtb3JlIGFyZ3VtZW50cyAqLworCWlmIChhLT5ucl9hcmdz
IDwgYi0+bnJfYXJncykKKwkJcmV0dXJuIGEtPm5yX2FyZ3MgKyAxOworCWlmIChhLT5ucl9hcmdz
ID4gYi0+bnJfYXJncykKKwkJcmV0dXJuIGItPm5yX2FyZ3MgKyAxOworCiAJZm9yIChpID0gMDsg
aSA8IGEtPm5yX2FyZ3M7IGkrKykgewogCQlpZiAoKGItPm5yX2FyZ3MgPD0gaSkgfHwKIAkJICAg
ICgoYS0+YXJnc1tpXS50eXBlICE9IGItPmFyZ3NbaV0udHlwZSkgfHwK

--Multipart=_Sat__28_Sep_2019_01_17_48_-0700_1/TJYCw71cUunfOk--
