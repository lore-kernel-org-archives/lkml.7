Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	UNPARSEABLE_RELAY autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDAA5C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 07:46:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 88F6620828
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 07:46:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="udfP7YcB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731106AbfCZHqb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 03:46:31 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:38012 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726042AbfCZHqa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 03:46:30 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x2Q7hx8s105827;
        Tue, 26 Mar 2019 07:45:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : subject
 : from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=corp-2018-07-02;
 bh=eDoMVVvxzjAeGpC/g/j/EEY/i7l9ZI6pwXrr5PXB4fs=;
 b=udfP7YcBo8F9v/QuL1LJZ4n8hOTDaVqYHVIIGZiodo3IEcOFLsY0C89WoEMxWX2+UtXr
 W3uzFW4fX4aTOVj+hSiIBn7EwuqUWAR+HJxzMoe8Ipaj3kwGbuaIIfgYZWNMS/tQQZYO
 5M+mECwoCbO+HnerUe7E6/q+fxwhBdvr0ibELDZ61Lwx9+OIAnSU3Ilif3b+JDYuLMQU
 JY1hzPYWZt2MTqVruFSSmlGCpV7ktjyLokPAx5oZ9GT9/VWtCIkI3ZmnJcuuC1GQ0i1y
 As5ZyKnHqmnwru86j5X46nmpNiSp2f1jtNhFR5V4zUoZcrQEddTt+donbLRG2O69uDek sg== 
Received: from aserv0022.oracle.com (aserv0022.oracle.com [141.146.126.234])
        by userp2130.oracle.com with ESMTP id 2re6g10jv1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 26 Mar 2019 07:45:05 +0000
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserv0022.oracle.com (8.14.4/8.14.4) with ESMTP id x2Q7j1ta011502
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 26 Mar 2019 07:45:01 GMT
Received: from abhmp0003.oracle.com (abhmp0003.oracle.com [141.146.116.9])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x2Q7imdx027791;
        Tue, 26 Mar 2019 07:44:49 GMT
Received: from abi.no.oracle.com (/141.143.213.38)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 26 Mar 2019 00:44:48 -0700
Message-ID: <a23e4d7f85b0c0daec25bb06ed3c4a1d078401d4.camel@oracle.com>
Subject: Re: [RFC v4 08/17] kunit: test: add support for test abort
From:   Knut Omang <knut.omang@oracle.com>
To:     Brendan Higgins <brendanhiggins@google.com>
Cc:     Frank Rowand <frowand.list@gmail.com>,
        Kees Cook <keescook@google.com>,
        Luis Chamberlain <mcgrof@kernel.org>, shuah@kernel.org,
        Rob Herring <robh@kernel.org>,
        Kieran Bingham <kieran.bingham@ideasonboard.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Joel Stanley <joel@jms.id.au>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Joe Perches <joe@perches.com>, brakmo@fb.com,
        Steven Rostedt <rostedt@goodmis.org>,
        "Bird, Timothy" <Tim.Bird@sony.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Julia Lawall <julia.lawall@lip6.fr>,
        linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jeff Dike <jdike@addtoit.com>,
        Richard Weinberger <richard@nod.at>,
        linux-um@lists.infradead.org, Daniel Vetter <daniel@ffwll.ch>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Dan Williams <dan.j.williams@intel.com>,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        devicetree <devicetree@vger.kernel.org>,
        Petr Mladek <pmladek@suse.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>,
        Amir Goldstein <amir73il@gmail.com>,
        Dan Carpenter <dan.carpenter@oracle.com>, wfg@linux.intel.com
Date:   Tue, 26 Mar 2019 08:44:41 +0100
In-Reply-To: <CAFd5g44eqjN-nVCJuoeYFCxwVa5AorWiAnXe-tFCAc11zDgJFA@mail.gmail.com>
References: <20190214213729.21702-1-brendanhiggins@google.com>
         <20190214213729.21702-9-brendanhiggins@google.com>
         <da1995fa-a362-dfe6-8184-7fcdf2b923e8@gmail.com>
         <CAFd5g467OV8wTB7zEshgZw8g8=zoq0dLVfwx3wDH-8UA+9GWFA@mail.gmail.com>
         <0124ed28-466c-e954-ddde-495419630a9f@gmail.com>
         <CAFd5g47EDmsBWKNiW0jpHW2VG_GWCfe8UO+=ofgM2_ru+_UBQA@mail.gmail.com>
         <118d89b7-d468-6d68-a48d-4d6d9cefd106@gmail.com>
         <CAFd5g46AP9yZQ+z+60HGaZuqhJQmfSBw9+r62w4k=cGiMEkqLA@mail.gmail.com>
         <e29d487f5ca0a5caf4723bc5d96b8a523a53a318.camel@oracle.com>
         <CAFd5g44eqjN-nVCJuoeYFCxwVa5AorWiAnXe-tFCAc11zDgJFA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.4 (3.30.4-1.fc29) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9206 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1903260059
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2019-03-25 at 15:32 -0700, Brendan Higgins wrote:
> On Fri, Mar 22, 2019 at 12:11 AM Knut Omang <knut.omang@oracle.com> wrote:
> > On Thu, 2019-03-21 at 18:41 -0700, Brendan Higgins wrote:
> > > On Thu, Mar 21, 2019 at 6:10 PM Frank Rowand <frowand.list@gmail.com> wrote:
> > > > On 2/27/19 11:42 PM, Brendan Higgins wrote:
> > > > > On Tue, Feb 19, 2019 at 10:44 PM Frank Rowand <frowand.list@gmail.com>
> > > > > wrote:
> > > > > > On 2/19/19 7:39 PM, Brendan Higgins wrote:
> > > > > > > On Mon, Feb 18, 2019 at 11:52 AM Frank Rowand <frowand.list@gmail.com>
> > > > > > > wrote:
> > > > > > > > On 2/14/19 1:37 PM, Brendan Higgins wrote:
> < snip >
> > > > > > > > kunit_abort() is what will be call as the result of an assert
> > > > > > > > failure.
> > > > > > > 
> > > > > > > Yep. Does that need clarified somewhere.
> > > > > > > > BUG(), which is a panic, which is crashing the system is not
> > > > > > > > acceptable
> > > > > > > > in the Linux kernel.  You will just annoy Linus if you submit this.
> > > > > > > 
> > > > > > > Sorry, I thought this was an acceptable use case since, a) this should
> > > > > > > never be compiled in a production kernel, b) we are in a pretty bad,
> > > > > > > unpredictable state if we get here and keep going. I think you might
> > > > > > > have said elsewhere that you think "a" is not valid? In any case, I
> > > > > > > can replace this with a WARN, would that be acceptable?
> > > > > > 
> > > > > > A WARN may or may not make sense, depending on the context.  It may
> > > > > > be sufficient to simply report a test failure (as in the old version
> > > > > > of case (2) below.
> > > > > > 
> > > > > > Answers to "a)" and "b)":
> > > > > > 
> > > > > > a) it might be in a production kernel
> > > > > 
> > > > > Sorry for a possibly stupid question, how might it be so? Why would
> > > > > someone intentionally build unit tests into a production kernel?
> > > > 
> > > > People do things.  Just expect it.
> > > 
> > > Huh, alright. I will take your word for it then.
> > 
> > I have a better explanation: Production kernels have bugs, unfortunately.
> > And sometimes those need to be investigated on systems than cannot be
> > brought down or affected more than absolutely necessary, maybe via a third party
> > doing the execution. A light weight, precise test (well tested ahead :) ) might
> > be a way of proving or disproving assumptions that can lead to the development
> > and application of a fix.
> 
> Sorry, you are not suggesting testing in production are you? To be
> clear, I am not concerned about someone using testing, KUnit, or
> whatever in a *production-like* environment: that's not what we are
> talking about here. My assumption is that no one will deploy tests
> into actual production.

And my take is that you should not make such assumptions.
Even the cost of bringing down a "production-like" environment can be
significant, and the test infrastructure shouldn't think of itself as 
important enough to justify doing such things.

> > IMHO you're confusing "building into" with temporary applying, then removing
> > again - like the difference between running a local user space program vs
> > installing it under /usr and have it in everyone's PATH.
> 
> I don't really see the point of distinguishing between "building into"
> and "temporary applying" in this case; that's part of my point. Maybe
> it makes sense in whitebox end-to-end testing, but in the case of unit
> testing, I don't think so.
> 
> > > > > > a') it is not acceptable in my development kernel either
> > 
> > I think one of the fundamental properties of a good test framework is that it
> > should not require changes to the code under test by itself.
> > 
> 
> Sure, but that has nothing to do with the environment the code/tests
> are running in.

Well, just that if the tests require a special environment to run, 
you limit the usability of the tests in detecting or ruling out real issues.

Thanks,
Knut

> 
> < snip >
> 
> Cheers

