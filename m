Return-Path: <SRS0=yZjE=R4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09AB0C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 19:18:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C82C220850
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 19:18:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553541506;
	bh=a887t5eklvbFtTZFcSHlHihbABPrYKtalakpQQQAdmg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=2CDzbpPb72EYqOytnDyE/8JT969m1hll8rfrcM2o/ggORICTGA8cXdBlh6oSAHuaG
	 tBp89vtAk3CDYblBPWeaWoZLmBeU9LRizdkw11v+ovWFoqqMkX6cp8IalOB1mVkqei
	 mXSkRhF7oz9eEtpnaMKe4ulegzOI0Wg1/9MI8DKY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729938AbfCYTSZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 15:18:25 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:46629 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729238AbfCYTSZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 15:18:25 -0400
Received: by mail-lj1-f195.google.com with SMTP id z26so8823852lja.13
        for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2019 12:18:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0hMH1ksPKkwE9nznbD/n/iCAqZ8z428QTn1BMeZ06U8=;
        b=P5stSdFDoIpWEVLzNmPGNaQ4ZhCw6c8Bug8L18StGfK1KLsMcgAqv1ZYZp+fAm3QsT
         zEOCBo8kYJu8CfcAEFZsdgOp8CLF8IARDs4wGrUnMGKKzcp5xJDKdjldfuLr9DTtLcqX
         3N0cppyqzoVz06WZh2dWkALVipq2Vv1MVs5UQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0hMH1ksPKkwE9nznbD/n/iCAqZ8z428QTn1BMeZ06U8=;
        b=mOvmX2jHQtRTQnz9PiMKg4Xpmbs3GDJXV6SAe3UPtesA34FaZDS3JXjuzcRB09mo/I
         8JzZvSj0AgQM7g8PE3ebk8mJ1nHEMNbwZ6Wciwk9Unw1cCa2/RJAx5I3D9rS/D6q0MTZ
         xctPB1OyF/7XRk8x+nAw47Xq7n7JK0LL2xQZtZmwSpI4DZMxI1oZ97ZqqHbq6Ir51mPn
         nP9/thDDxJA++1yIyV5MR6XzXkvar7otNQMIV3FiUogX7PUsaiuTRvGU+iOWa+gpRD1O
         ARnHc1nN6AR435ueI08e0Ci4DGHZ1D1h3YUzET5ozWAbupHumNI25poJm2FloXkC63SU
         H3BA==
X-Gm-Message-State: APjAAAWrhJjb5LS2kRaxvKNi1rsipSdG2YG8jMt8dY/DEqP8vWfQPrMT
        bi5eGOwuvtv/8C0zsLAVmBBXIH77aIY=
X-Google-Smtp-Source: APXvYqxQOCy0wy1MGYLOmg690YH+Cen+Am2k2sGSCL1x/slqw4BSRbawAwEQskrg+rxM3g0dEqKkag==
X-Received: by 2002:a2e:884a:: with SMTP id z10mr6988584ljj.21.1553541502320;
        Mon, 25 Mar 2019 12:18:22 -0700 (PDT)
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com. [209.85.208.180])
        by smtp.gmail.com with ESMTPSA id k2sm73278lfb.62.2019.03.25.12.18.19
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 25 Mar 2019 12:18:20 -0700 (PDT)
Received: by mail-lj1-f180.google.com with SMTP id f18so8894339lja.10
        for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2019 12:18:19 -0700 (PDT)
X-Received: by 2002:a2e:8149:: with SMTP id t9mr14172814ljg.2.1553541499501;
 Mon, 25 Mar 2019 12:18:19 -0700 (PDT)
MIME-Version: 1.0
References: <0000000000006946d2057bbd0eef@google.com> <CAHk-=wiijJMTw=nTj_ED+YWMCrvHzh3ezfVYRxvzcW6+trgyPA@mail.gmail.com>
 <20190325045744.GK2217@ZenIV.linux.org.uk> <CAHk-=wg4iJsMHBzK52WzP+5_92HbwvX_vh_s4mMUuN0FJGdM5A@mail.gmail.com>
In-Reply-To: <CAHk-=wg4iJsMHBzK52WzP+5_92HbwvX_vh_s4mMUuN0FJGdM5A@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 25 Mar 2019 12:18:02 -0700
X-Gmail-Original-Message-ID: <CAHk-=whJ4M5FegOLvnjUtJ0+pHv4L8UNFt+9jJDhox3Ada8kwA@mail.gmail.com>
Message-ID: <CAHk-=whJ4M5FegOLvnjUtJ0+pHv4L8UNFt+9jJDhox3Ada8kwA@mail.gmail.com>
Subject: Re: KASAN: use-after-free Read in path_lookupat
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     syzbot <syzbot+7a8ba368b47fdefca61e@syzkaller.appspotmail.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>
Content-Type: multipart/mixed; boundary="00000000000038f0820584f0114f"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--00000000000038f0820584f0114f
Content-Type: text/plain; charset="UTF-8"

On Mon, Mar 25, 2019 at 11:36 AM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
> >
> > You mean, split ->destroy_inode() into immediate and RCU-delayed parts?
> > There are filesystems where both parts are non-empty - we can't just
> > switch all ->destroy_inode() work to call_rcu().
>
> Right. Not just move the existing destroy_inode() - because as you
> say, people may not be able to to do that in RCU contect, but split it
> up, and add a "final_free_inode()" callback or something for the RCU
> phase.

Something like the attached.

COMPLETELY UNTESTED. And no filesystems converted to actually use the
new rcu_destroy_inode() thing.

Hmm?

                Linus

--00000000000038f0820584f0114f
Content-Type: text/x-patch; charset="US-ASCII"; name="patch.diff"
Content-Disposition: attachment; filename="patch.diff"
Content-Transfer-Encoding: base64
Content-ID: <f_jtoqhif90>
X-Attachment-Id: f_jtoqhif90

IERvY3VtZW50YXRpb24vZmlsZXN5c3RlbXMvdmZzLnR4dCB8ICA2ICsrKysrKwogZnMvaW5vZGUu
YyAgICAgICAgICAgICAgICAgICAgICAgIHwgMjcgKysrKysrKysrKysrKysrKysrKysrLS0tLS0t
CiBpbmNsdWRlL2xpbnV4L2ZzLmggICAgICAgICAgICAgICAgfCAgMSArCiAzIGZpbGVzIGNoYW5n
ZWQsIDI4IGluc2VydGlvbnMoKyksIDYgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvRG9jdW1l
bnRhdGlvbi9maWxlc3lzdGVtcy92ZnMudHh0IGIvRG9jdW1lbnRhdGlvbi9maWxlc3lzdGVtcy92
ZnMudHh0CmluZGV4IDc2MWM2ZmQyNGE1My4uNjBmNzg0MWExMmU2IDEwMDY0NAotLS0gYS9Eb2N1
bWVudGF0aW9uL2ZpbGVzeXN0ZW1zL3Zmcy50eHQKKysrIGIvRG9jdW1lbnRhdGlvbi9maWxlc3lz
dGVtcy92ZnMudHh0CkBAIC0yMTAsNiArMjEwLDcgQEAgZmlsZXN5c3RlbS4gQXMgb2Yga2VybmVs
IDIuNi4yMiwgdGhlIGZvbGxvd2luZyBtZW1iZXJzIGFyZSBkZWZpbmVkOgogc3RydWN0IHN1cGVy
X29wZXJhdGlvbnMgewogICAgICAgICBzdHJ1Y3QgaW5vZGUgKigqYWxsb2NfaW5vZGUpKHN0cnVj
dCBzdXBlcl9ibG9jayAqc2IpOwogICAgICAgICB2b2lkICgqZGVzdHJveV9pbm9kZSkoc3RydWN0
IGlub2RlICopOworICAgICAgICBpbnQgKCpyY3VfZGVzdHJveV9pbm9kZSkoc3RydWN0IGlub2Rl
ICopOwogCiAgICAgICAgIHZvaWQgKCpkaXJ0eV9pbm9kZSkgKHN0cnVjdCBpbm9kZSAqLCBpbnQg
ZmxhZ3MpOwogICAgICAgICBpbnQgKCp3cml0ZV9pbm9kZSkgKHN0cnVjdCBpbm9kZSAqLCBpbnQp
OwpAQCAtMjQ4LDYgKzI0OSwxMSBAQCBvciBib3R0b20gaGFsZikuCiAgIAktPmFsbG9jX2lub2Rl
IHdhcyBkZWZpbmVkIGFuZCBzaW1wbHkgdW5kb2VzIGFueXRoaW5nIGRvbmUgYnkKIAktPmFsbG9j
X2lub2RlLgogCisgcmN1X2Rlc3Ryb3lfaW5vZGU6IHRoaXMgbWV0aG9kIGlzIGNhbGxlZCBhZnRl
ciB0aGUgUkNVIGRlbGF5IGJ5CisJZGVzdHJveV9pbm9kZSgpIHRvIHJlbGVhc2UgcmVzb3VyY2Vz
IGFsbG9jYXRlZCBmb3Igc3RydWN0IGlub2RlLgorCUlmIGl0IHJldHVybnMgYSBub24temVybyB2
YWx1ZSwgaXQgbWVhbnMgdGhhdCBpdCBoYXMgZnJlZSdkIHRoZQorCWlub2RlLCBvdGhlcndpc2Ug
dGhlIGlub2RlIGxheWVyIHdpbGwgZnJlZSBpdC4KKwogICBkaXJ0eV9pbm9kZTogdGhpcyBtZXRo
b2QgaXMgY2FsbGVkIGJ5IHRoZSBWRlMgdG8gbWFyayBhbiBpbm9kZSBkaXJ0eS4KIAogICB3cml0
ZV9pbm9kZTogdGhpcyBtZXRob2QgaXMgY2FsbGVkIHdoZW4gdGhlIFZGUyBuZWVkcyB0byB3cml0
ZSBhbgpkaWZmIC0tZ2l0IGEvZnMvaW5vZGUuYyBiL2ZzL2lub2RlLmMKaW5kZXggZTlkOTdhZGQy
YjM2Li5iODU0NTdiYWFkMjAgMTAwNjQ0Ci0tLSBhL2ZzL2lub2RlLmMKKysrIGIvZnMvaW5vZGUu
YwpAQCAtMjE1LDkgKzIxNSwxMyBAQCBzdGF0aWMgc3RydWN0IGlub2RlICphbGxvY19pbm9kZShz
dHJ1Y3Qgc3VwZXJfYmxvY2sgKnNiKQogCQlyZXR1cm4gTlVMTDsKIAogCWlmICh1bmxpa2VseShp
bm9kZV9pbml0X2Fsd2F5cyhzYiwgaW5vZGUpKSkgewotCQlpZiAoaW5vZGUtPmlfc2ItPnNfb3At
PmRlc3Ryb3lfaW5vZGUpCisJCWlmIChpbm9kZS0+aV9zYi0+c19vcC0+ZGVzdHJveV9pbm9kZSkg
ewogCQkJaW5vZGUtPmlfc2ItPnNfb3AtPmRlc3Ryb3lfaW5vZGUoaW5vZGUpOwotCQllbHNlCisJ
CQlpZiAoIWlub2RlLT5pX3NiLT5zX29wLT5yY3VfZGVzdHJveV9pbm9kZSkKKwkJCQlyZXR1cm4g
TlVMTDsKKwkJfQorCQlpZiAoIWlub2RlLT5pX3NiLT5zX29wLT5yY3VfZGVzdHJveV9pbm9kZSB8
fAorCQkgICAgIWlub2RlLT5pX3NiLT5zX29wLT5yY3VfZGVzdHJveV9pbm9kZShpbm9kZSkpCiAJ
CQlrbWVtX2NhY2hlX2ZyZWUoaW5vZGVfY2FjaGVwLCBpbm9kZSk7CiAJCXJldHVybiBOVUxMOwog
CX0KQEAgLTI1NiwxNyArMjYwLDI4IEBAIEVYUE9SVF9TWU1CT0woX19kZXN0cm95X2lub2RlKTsK
IHN0YXRpYyB2b2lkIGlfY2FsbGJhY2soc3RydWN0IHJjdV9oZWFkICpoZWFkKQogewogCXN0cnVj
dCBpbm9kZSAqaW5vZGUgPSBjb250YWluZXJfb2YoaGVhZCwgc3RydWN0IGlub2RlLCBpX3JjdSk7
Ci0Ja21lbV9jYWNoZV9mcmVlKGlub2RlX2NhY2hlcCwgaW5vZGUpOworCisJaWYgKCFpbm9kZS0+
aV9zYi0+c19vcC0+cmN1X2Rlc3Ryb3lfaW5vZGUgfHwKKwkgICAgIWlub2RlLT5pX3NiLT5zX29w
LT5yY3VfZGVzdHJveV9pbm9kZShpbm9kZSkpCisJCWttZW1fY2FjaGVfZnJlZShpbm9kZV9jYWNo
ZXAsIGlub2RlKTsKIH0KIAogc3RhdGljIHZvaWQgZGVzdHJveV9pbm9kZShzdHJ1Y3QgaW5vZGUg
Kmlub2RlKQogewogCUJVR19PTighbGlzdF9lbXB0eSgmaW5vZGUtPmlfbHJ1KSk7CiAJX19kZXN0
cm95X2lub2RlKGlub2RlKTsKLQlpZiAoaW5vZGUtPmlfc2ItPnNfb3AtPmRlc3Ryb3lfaW5vZGUp
CisKKwkvKgorCSAqIElmIHdlIGhhdmUgYSAnZGVzdHJveV9pbm9kZScgYnV0IG5vICdyY3VfZGVz
dHJveV9pbm9kZScKKwkgKiB0aGVuIHRoZSBmaWxlc3lzdGVtIGhhbmRsZXMgdGhlIFJDVS1kZWxh
eWVkIGRlc3RydWN0aW9uCisJICogb24gaXRzIG93biwgYW5kIHdlIGRvbid0IGRvIGFueSBSQ1Ug
Y2FsbGJhY2tzLgorCSAqLworCWlmIChpbm9kZS0+aV9zYi0+c19vcC0+ZGVzdHJveV9pbm9kZSkg
ewogCQlpbm9kZS0+aV9zYi0+c19vcC0+ZGVzdHJveV9pbm9kZShpbm9kZSk7Ci0JZWxzZQotCQlj
YWxsX3JjdSgmaW5vZGUtPmlfcmN1LCBpX2NhbGxiYWNrKTsKKwkJaWYgKCFpbm9kZS0+aV9zYi0+
c19vcC0+cmN1X2Rlc3Ryb3lfaW5vZGUpCisJCQlyZXR1cm47CisJfQorCWNhbGxfcmN1KCZpbm9k
ZS0+aV9yY3UsIGlfY2FsbGJhY2spOwogfQogCiAvKioKZGlmZiAtLWdpdCBhL2luY2x1ZGUvbGlu
dXgvZnMuaCBiL2luY2x1ZGUvbGludXgvZnMuaAppbmRleCA4YjQyZGYwOWIwNGMuLjcyNzU2MWVj
YmMyMyAxMDA2NDQKLS0tIGEvaW5jbHVkZS9saW51eC9mcy5oCisrKyBiL2luY2x1ZGUvbGludXgv
ZnMuaApAQCAtMTkwMCw2ICsxOTAwLDcgQEAgZXh0ZXJuIGxvZmZfdCB2ZnNfZGVkdXBlX2ZpbGVf
cmFuZ2Vfb25lKHN0cnVjdCBmaWxlICpzcmNfZmlsZSwgbG9mZl90IHNyY19wb3MsCiBzdHJ1Y3Qg
c3VwZXJfb3BlcmF0aW9ucyB7CiAgICAJc3RydWN0IGlub2RlICooKmFsbG9jX2lub2RlKShzdHJ1
Y3Qgc3VwZXJfYmxvY2sgKnNiKTsKIAl2b2lkICgqZGVzdHJveV9pbm9kZSkoc3RydWN0IGlub2Rl
ICopOworCWludCAoKnJjdV9kZXN0cm95X2lub2RlKShzdHJ1Y3QgaW5vZGUgKik7CiAKICAgIAl2
b2lkICgqZGlydHlfaW5vZGUpIChzdHJ1Y3QgaW5vZGUgKiwgaW50IGZsYWdzKTsKIAlpbnQgKCp3
cml0ZV9pbm9kZSkgKHN0cnVjdCBpbm9kZSAqLCBzdHJ1Y3Qgd3JpdGViYWNrX2NvbnRyb2wgKndi
Yyk7Cg==
--00000000000038f0820584f0114f--
