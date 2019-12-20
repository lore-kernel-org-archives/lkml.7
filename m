Return-Path: <SRS0=w7sF=2K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1183CC43603
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Dec 2019 16:40:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D3B1820716
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Dec 2019 16:40:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=mikemestnik-net.20150623.gappssmtp.com header.i=@mikemestnik-net.20150623.gappssmtp.com header.b="pvIYYCay"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727417AbfLTQkG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Dec 2019 11:40:06 -0500
Received: from mail-vk1-f179.google.com ([209.85.221.179]:36652 "EHLO
        mail-vk1-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727181AbfLTQkF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Dec 2019 11:40:05 -0500
Received: by mail-vk1-f179.google.com with SMTP id i4so2770552vkc.3
        for <linux-kernel@vger.kernel.org>; Fri, 20 Dec 2019 08:40:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mikemestnik-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:from:date:message-id:subject:to;
        bh=Szt8eXgLGqLENPC5c/6IBOHsWrH3UT5g9f383dKNd6I=;
        b=pvIYYCayUMQrn/09DDaAaAz9YH/eWvX83bwnHv0TguLckHE/B5mpV1rKLfLPrwOxep
         k/6ejiVvyAgh6F4V6NsYcH7fx3A3uUn5iDv7/BpIkb/XN0kBof+n9YskgHA45xUSNZ5t
         a0C11p+h8BNEFske3PYYs8D3QylyOE/jykpUVDCs/7O32F3HM4U0Hq0xM1LcO6Q0mnVz
         PhcmZGsCNen/hs3/BKpn9tcTIq92KcRLM/9ojdEqg3ab3BgFDDWSRH3oHqtQt5SlIuMN
         mVndFJu8fXJT/JOvxMgUnC6nJhalTS+bc2dnKtlcqG6XcL07R7Xi0nYAGvX48ndSQcCW
         b/Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=Szt8eXgLGqLENPC5c/6IBOHsWrH3UT5g9f383dKNd6I=;
        b=mMwRSouMlftPEs7mCXV0CTnRRv1eiKrM7Sp/uAoXvp+AdkCoB2SWAmvwzlKgfzp95w
         OoRDUx9k8HwtUj2ARsrvIJOomqv5gYVouHLrMc0VGC7fl1FpZDrK5sbmHllt+tiNAXqN
         Jo0nA3KQPq2xJ5Fmwxo6rh74WFMcgPY3FefFi0aqGYGZYtkGJMH10vMxL//H0Pf/ofXr
         44gL+a3tj3BnGKe5aTFw/7KJn/4iMLkzPIEdBkKUflfzm695sNuefoyj/lsaq8j424c1
         wi+Gtd9LZ6TxWp3s672wa8PvnO4n0LT9002+D2UdGIvNh+WVFdtYYjTw91HnTo6qLHoC
         655A==
X-Gm-Message-State: APjAAAXuUVR96E4sEzUmjg8FrUVTrlswpwfyc6lzOjVrViWC4uYuz5ek
        brsG6x1Uevg5pHk+h4ZuB2hEAz/WueJG3WwcHGGCFwAtky4=
X-Google-Smtp-Source: APXvYqzRz6Wk5ylhZ6QcbAxLHTzAj+zlERNyPNWhHiujuKoaSxXZVcwDfYzVLBJ+Jo4P7ny1aKvXrlREDPzFf/q79jA=
X-Received: by 2002:a1f:252:: with SMTP id 79mr10575894vkc.96.1576860004685;
 Fri, 20 Dec 2019 08:40:04 -0800 (PST)
MIME-Version: 1.0
From:   Mike Mestnik <cheako@mikemestnik.net>
Date:   Fri, 20 Dec 2019 10:39:53 -0600
Message-ID: <CAF8px57Sawr1COPueoXt-Tso++_Vyt=XLfUcXxNvv-M1590cDg@mail.gmail.com>
Subject: System freeze log.
To:     linux-kernel@vger.kernel.org
Content-Type: multipart/mixed; boundary="00000000000070cfe3059a255403"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--00000000000070cfe3059a255403
Content-Type: text/plain; charset="UTF-8"

https://pastebin.com/k7CqCwPz

--00000000000070cfe3059a255403
Content-Type: text/plain; charset="US-ASCII"; name="messages.txt"
Content-Disposition: attachment; filename="messages.txt"
Content-Transfer-Encoding: base64
Content-ID: <f_k4edq2q30>
X-Attachment-Id: f_k4edq2q30

RGVjIDIwIDA4OjM0OjMxIG55c2Ega2VybmVsOiBbIDI1OTUuMTA5NDc3XSBwZXJmOiBpbnRlcnJ1
cHQgdG9vayB0b28gbG9uZyAoNDA2MCA+IDQwMzApLCBsb3dlcmluZyBrZXJuZWwucGVyZl9ldmVu
dF9tYXhfc2FtcGxlX3JhdGUgdG8gNDkyNTAKRGVjIDIwIDA4OjQyOjU1IG55c2Ega2VybmVsOiBb
IDMwOTkuMjgwNDUzXSBwZXJmOiBpbnRlcnJ1cHQgdG9vayB0b28gbG9uZyAoNTEyMCA+IDUwNzUp
LCBsb3dlcmluZyBrZXJuZWwucGVyZl9ldmVudF9tYXhfc2FtcGxlX3JhdGUgdG8gMzkwMDAKRGVj
IDIwIDA4OjQzOjA0IG55c2EgL3Vzci9saWIvZ2RtMy9nZG0teC1zZXNzaW9uWzE2MzldOiAoRUUp
IGNsaWVudCBidWc6IHRpbWVyIGV2ZW50NyBkZWJvdW5jZTogb2Zmc2V0IG5lZ2F0aXZlICgtMW1z
KQpEZWMgMjAgMDg6NDM6MDQgbnlzYSAvdXNyL2xpYi9nZG0zL2dkbS14LXNlc3Npb25bMTYzOV06
IChFRSkgY2xpZW50IGJ1ZzogdGltZXIgZXZlbnQ3IGRlYm91bmNlIHNob3J0OiBvZmZzZXQgbmVn
YXRpdmUgKC0xNW1zKQpEZWMgMjAgMDg6NTI6NDEgbnlzYSBzdGVhbS5kZXNrdG9wWzE3NThdOiBJ
bnN0YWxsaW5nIGJyZWFrcGFkIGV4Y2VwdGlvbiBoYW5kbGVyIGZvciBhcHBpZChzdGVhbSkvdmVy
c2lvbigxNTc2NzE3NTQxKQpEZWMgMjAgMDg6NTQ6MDAgbnlzYSBrZXJuZWw6IFsgMzc2My43OTg1
MTBdIHBlcmY6IGludGVycnVwdCB0b29rIHRvbyBsb25nICg2NDAxID4gNjQwMCksIGxvd2VyaW5n
IGtlcm5lbC5wZXJmX2V2ZW50X21heF9zYW1wbGVfcmF0ZSB0byAzMTAwMApEZWMgMjAgMDg6NTU6
NDggbnlzYSAvdXNyL2xpYi9nZG0zL2dkbS14LXNlc3Npb25bMTYzOV06IChFRSkgY2xpZW50IGJ1
ZzogdGltZXIgZXZlbnQ3IGRlYm91bmNlIHNob3J0OiBvZmZzZXQgbmVnYXRpdmUgKC0zbXMpCkRl
YyAyMCAwOTowMzoxNyBueXNhIHN0ZWFtLmRlc2t0b3BbMTc1OF06IEluc3RhbGxpbmcgYnJlYWtw
YWQgZXhjZXB0aW9uIGhhbmRsZXIgZm9yIGFwcGlkKHN0ZWFtKS92ZXJzaW9uKDE1NzY3MTc1NDEp
CkRlYyAyMCAwOTowNjo0NCBueXNhIC91c3IvbGliL2dkbTMvZ2RtLXgtc2Vzc2lvblsxNjM5XTog
KEVFKSBjbGllbnQgYnVnOiB0aW1lciBldmVudDYgdHJhY2twb2ludDogb2Zmc2V0IG5lZ2F0aXZl
ICgtMTBtcykKRGVjIDIwIDA5OjA2OjQ0IG55c2EgL3Vzci9saWIvZ2RtMy9nZG0teC1zZXNzaW9u
WzE2MzldOiAoRUUpIGNsaWVudCBidWc6IHRpbWVyIGV2ZW50NiB0cmFja3BvaW50OiBvZmZzZXQg
bmVnYXRpdmUgKC00Nm1zKQpEZWMgMjAgMDk6MTQ6MDkgbnlzYSBzdGVhbS5kZXNrdG9wWzE3NThd
OiBUSFJFQUQgLSBzdGFydGVkICdTaW1UaHJlYWQnICgxNDA3MTExMzAyOTQwMTYpCkRlYyAyMCAw
OToxOTo1MSBueXNhIGtlcm5lbDogWyA1MzE1LjEzNjY4Ml0gcGVyZjogaW50ZXJydXB0IHRvb2sg
dG9vIGxvbmcgKDgwNTEgPiA4MDAxKSwgbG93ZXJpbmcga2VybmVsLnBlcmZfZXZlbnRfbWF4X3Nh
bXBsZV9yYXRlIHRvIDI0NzUwCkRlYyAyMCAwOTozMTo0MCBueXNhIC91c3IvbGliL2dkbTMvZ2Rt
LXgtc2Vzc2lvblsxNjM5XTogKEVFKSBjbGllbnQgYnVnOiB0aW1lciBldmVudDYgdHJhY2twb2lu
dDogb2Zmc2V0IG5lZ2F0aXZlICgtMTBtcykKRGVjIDIwIDA5OjM5OjM5IG55c2EgL3Vzci9saWIv
Z2RtMy9nZG0teC1zZXNzaW9uWzE2MzldOiAoRUUpIGNsaWVudCBidWc6IHRpbWVyIGV2ZW50NyBk
ZWJvdW5jZTogb2Zmc2V0IG5lZ2F0aXZlICgtMm1zKQpEZWMgMjAgMDk6NDc6MDEgbnlzYSBzdGVh
bS5kZXNrdG9wWzE3NThdOiBJbnN0YWxsaW5nIGJyZWFrcGFkIGV4Y2VwdGlvbiBoYW5kbGVyIGZv
ciBhcHBpZChzdGVhbSkvdmVyc2lvbigxNTc2NzE3NTQxKQpEZWMgMjAgMTA6MDg6MjMgbnlzYSAv
dXNyL2xpYi9nZG0zL2dkbS14LXNlc3Npb25bMTYzOV06IChFRSkgY2xpZW50IGJ1ZzogdGltZXIg
ZXZlbnQ3IGRlYm91bmNlIHNob3J0OiBvZmZzZXQgbmVnYXRpdmUgKC03bXMpCkRlYyAyMCAxMDox
NzoxNyBueXNhIG10cC1wcm9iZTogY2hlY2tpbmcgYnVzIDMsIGRldmljZSAzOiAiL3N5cy9kZXZp
Y2VzL3BjaTAwMDA6MDAvMDAwMDowMDowOC4xLzAwMDA6MDU6MDAuNC91c2IzLzMtMiIKRGVjIDIw
IDEwOjE3OjE3IG55c2EgbXRwLXByb2JlOiBidXM6IDMsIGRldmljZTogMyB3YXMgbm90IGFuIE1U
UCBkZXZpY2UKRGVjIDIwIDEwOjE3OjE3IG55c2EgdWRpc2tzZFs1OTJdOiB1ZGlza3MgZGFlbW9u
IHZlcnNpb24gMi44LjIgc3RhcnRpbmcKRGVjIDIwIDEwOjE3OjE3IG55c2Ega2VybmVsOiBbICAg
IDAuMDAwMDAwXSBMaW51eCB2ZXJzaW9uIDQuMTkuMC02LWFtZDY0IChkZWJpYW4ta2VybmVsQGxp
c3RzLmRlYmlhbi5vcmcpIChnY2MgdmVyc2lvbiA4LjMuMCAoRGViaWFuIDguMy4wLTYpKSAjMSBT
TVAgRGViaWFuIDQuMTkuNjctMitkZWIxMHUxICgyMDE5LTA5LTIwKQpEZWMgMjAgMTA6MTc6MTcg
bnlzYSBrZXJuZWw6IFsgICAgMC4wMDAwMDBdIENvbW1hbmQgbGluZTogQk9PVF9JTUFHRT0vYm9v
dC92bWxpbnV6LTQuMTkuMC02LWFtZDY0IHJvb3Q9VVVJRD0wNzE4OTdlYi1jN2NlLTRiMWQtOWY2
Zi1iZTYzNDAxYjUzMmYgcm8gaWRsZT1ub213YWl0IGFtZGdwdS5ncHVfcmVjb3Zlcnk9MSBxdWll
dAoK
--00000000000070cfe3059a255403--
