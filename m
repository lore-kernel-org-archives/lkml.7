Return-Path: <SRS0=qJmF=WX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C465C3A59F
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 00:06:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E7C42173E
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 00:06:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727443AbfH0AGe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Aug 2019 20:06:34 -0400
Received: from mga11.intel.com ([192.55.52.93]:54902 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726543AbfH0AGe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Aug 2019 20:06:34 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 26 Aug 2019 17:06:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,435,1559545200"; 
   d="gz'50?scan'50,208,50";a="174373620"
Received: from lkp-server01.sh.intel.com (HELO lkp-server01) ([10.239.97.150])
  by orsmga008.jf.intel.com with ESMTP; 26 Aug 2019 17:06:30 -0700
Received: from kbuild by lkp-server01 with local (Exim 4.89)
        (envelope-from <lkp@intel.com>)
        id 1i2P0I-0009SY-59; Tue, 27 Aug 2019 08:06:30 +0800
Date:   Tue, 27 Aug 2019 08:06:26 +0800
From:   kbuild test robot <lkp@intel.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     kbuild-all@01.org, Satendra Singh Thakur <sst2005@gmail.com>,
        satendrasingh.thakur@hcl.com, Ingo Molnar <mingo@redhat.com>,
        Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: sched,time: Allow better constprop/DCE for schedule_timeout()
Message-ID: <201908270846.KbeyHGyg%lkp@intel.com>
References: <20190826142557.GM2386@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="q3pyezv7obcxgzvx"
Content-Disposition: inline
In-Reply-To: <20190826142557.GM2386@hirez.programming.kicks-ass.net>
X-Patchwork-Hint: ignore
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--q3pyezv7obcxgzvx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Peter,

I love your patch! Yet something to improve:

[auto build test ERROR on linus/master]
[cannot apply to v5.3-rc6 next-20190826]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Peter-Zijlstra/sched-time-Allow-better-constprop-DCE-for-schedule_timeout/20190827-061612
config: um-x86_64_defconfig (attached as .config)
compiler: gcc-7 (Debian 7.4.0-10) 7.4.0
reproduce:
        # save the attached .config to linux build tree
        make ARCH=um SUBARCH=x86_64

If you fix the issue, kindly add following tag
Reported-by: kbuild test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   In file included from arch/x86/um/shared/sysdep/kernel-offsets.h:3:0,
                    from arch/um/kernel/asm-offsets.c:1:
   include/linux/sched.h: In function 'schedule_timeout':
>> include/linux/sched.h:222:3: error: implicit declaration of function 'schedule'; did you mean 'schedule_work'? [-Werror=implicit-function-declaration]
      schedule();
      ^~~~~~~~
      schedule_work
   include/linux/sched.h: At top level:
   include/linux/sched.h:233:17: warning: conflicting types for 'schedule'
    asmlinkage void schedule(void);
                    ^~~~~~~~
   include/linux/sched.h:222:3: note: previous implicit declaration of 'schedule' was here
      schedule();
      ^~~~~~~~
   cc1: some warnings being treated as errors
   make[2]: *** [arch/um/kernel/asm-offsets.s] Error 1
   make[2]: Target '__build' not remade because of errors.
   make[1]: *** [prepare0] Error 2
   make[1]: Target 'prepare' not remade because of errors.
   make: *** [sub-make] Error 2
   8 real  6 user  4 sys  130.06% cpu 	make prepare

vim +222 include/linux/sched.h

   218	
   219	static inline long schedule_timeout(long timeout)
   220	{
   221		if (__builtin_constant_p(timeout) && timeout == MAX_SCHEDULE_TIMEOUT) {
 > 222			schedule();
   223			return timeout;
   224		}
   225	
   226		return __schedule_timeout(timeout);
   227	}
   228	

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation

--q3pyezv7obcxgzvx
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

H4sICKdvZF0AAy5jb25maWcAnDzbctu4ku/nK1iZqq2kziZxnMSTnC0/QCAoYUQSNEBKsl9Y
isQkqrElryTPJH+/DfAGkA1naqvOGYfdjVuj7wD0279+C8jT+fCwPu826/v7n8G3al8d1+dq
G3zd3Vf/E4QiSEUesJDnb4A43u2ffrx9egg+vnn/5uL1cXMVzKvjvroP6GH/dfftCdruDvt/
/fYv+N9vAHx4hG6O/wm+bTavfw9ehtWX3Xof/P7mA7R+d/Gq/hfQUpFGfFpSWnJVTim9/tmC
4KNcMKm4SK9/v/hwcdHRxiSddqgLqwtK0jLm6bzvBIAzokqiknIqcjFCLIlMy4TcTlhZpDzl
OScxv2OhQxhyRSYx+wfEXN6USyH1BAwfpoar98GpOj899qudSDFnaSnSUiWZ1Rq6LFm6KImc
wjoSnl+/u/yk2VnjZ4yETJY5U3mwOwX7w1l33LaOBSVxy5UXLzBwSQqbB5OCx2GpSJxb9CGL
SBHn5UyoPCUJu37xcn/YV686ArUk1pzVrVrwjI4A+i/N4x6eCcVXZXJTsILh0FETKoVSZcIS
IW9LkueEzgDZsaNQLOYTmxMdihQgtwiPZmTBgLt0VlPoAUkct7sFuxecnr6cfp7O1UO/W1OW
Msmp2Vw1E0szh2q/DQ5fB02GLSgwf84WLM1VO0a+e6iOJ2yYnNM5iASDIfKeB6koZ3clFUkC
u2otHoAZjCFCTpF11q14GLNBT/3njE9npWQKxk1AOuxFjebY7ZZkLMly6Cpl7YJoVrzN16c/
gzO0CtbQw+m8Pp+C9WZzeNqfd/tvgyVCg5JQKoo05+nUkkYVwgCCMthzwOf2aoe4cvEe3fec
qLnKSa5QbKa4C2/W+w+WYJYqaREobOPS2xJw9oThs2Qr2CFMClVNbDdXbftmSu5QnYGY1/+w
TMa82xpB7QnweW0tFGoptO5HIMw8AhPzod9enuZzMAgRG9K8rzmgNt+r7RMY9uBrtT4/HauT
ATeTRrCdKk+lKDJlzxD0mk6R2U3ieUNuWQLzXSo6s61tRLgsXUzXO41UOSFpuORhPkOlQeZ2
W5SkGTbjIS5QDV6GCUEW0mAjUJo7JkeLCdmCUzYCgzAOpb9rMCkwhmkrrTICytF3VuSqTK1v
bZFTNbCeEkC4ovBwgGqHYvmgG+AdnWcCBEcbk1xIhvZoeGzcj1kLphS3CrYsZGBjKMndzRzi
ysUlvqUsJrcoRgsVMNy4WOnZbFqKDIwhePQyElKbV/iTkJQybHMH1Ar+4ThBx5MZv1Pw8N2V
Ze+yyF6j11oMmiXgnLnePGc0YE/vzFr1mIH8xyNn29l7R+vtqMCyLyyOwPlIq5MJUbDiwhmo
yNlq8AkyNFh+DaZJtqIze4RM2H0pPk1JHFlabuZrA4xDtQFqBrak/yTcinG4KAvp+BkSLrhi
LbssRkAnEyIlt1k71yS3iSPyLayEv8h+dWjDKS2SOV8wx5tlUTs8Kol6d00QFuGSCvNkYeja
LGOHm5A8q45fD8eH9X5TBeyvag+ujICFptqZgWO3TfY/bNGubZHU3C+N+3bECEKUjOQQ2lqi
pGIycfQ4LiaY6gMZcF9OWRt9uo0Aq41ozBUYGZBpkeA2ZlZEEYTpGYGOgLcQ+II9wg2cFBGH
TGGKxgNu1G7YVSTx69Njtdl93W2Cw6POdU59BABYS4wSy7lD0MWFI525BEutY8koJlPQ2iLL
hLQCPh0ygqUbIyCuofO69QjXBZyQkEwkmEhgJJhCSwPvrt/1GVQqtZtR1+/qxc0Op3PweDxs
qtPpcAzOPx/rKMjx8e3q5p9QjiaZojhCmw/cXCewPwkiD91qMouTq09XYL1B5lIRMlgoOJQm
OLmySeJ3flyuqNtfY4yuPgzBYuFCEvAbSZGY2DUiCY9vr6+6sEkDYUfM7OzspQGTJBwDZ7dT
E88PwBR0ixRyjLibEbHiqR0i/nLXLOnUi+g7vfow4bm7QJsFJj8CRWxizRfr4+Y7pP5vNybT
P739YejLbfW1hnSZ4fsyBusQl9k01/myGsvnbMkg7XDVG8J1wOi0HQtVIT+lkkPOEd5a/NLJ
aWSbbvirhO3rEjLlJgmVN5Y1B+mB+RlNKoWE8Pj60hLHhGTgg/F0CkI8y2XWC6yXq67fdyrK
qDaDTpgFzNceTOu95k2juqjdQY1Ma34C+n19XG/AHAdh9dduU1n2R+WwFNDpIROUsuQxBZ8N
4Rqx2KhnMgTltwNIPoKsQAuTAQz+lBDlihr84uv2Pxf/Df9598ImqHGP59MLa4YIVDNNgYcJ
rx86QuSz1OUBNzrRgqFTewGkNl8R7nWMTavz34fjn2O26mlAxGtF1TWgZPkMYjW7DNJicnCL
GFzFHIGGhA3S+hazYNTnuzqSEItLW2xCicqxnjNKsPDbmqjMbDODccipbWnzsDtXG210Xm+r
R2gHAcTYSVJJ1Gy4XV09plGdEtxy7sS2HnhTvzOqDN48N/xqCxN27wuuZdypOWhzZFkKERZg
rHTUZcJdHbENbKXR4IGBBJvQlEOcvF+bTRjFRMij+GxKxeL1l/Wp2gZ/1oEX2O+vu/u6SNLH
H8+QdXoaF1OeGnmn9PrFt3//+4WzbF09rWlsM+wAmynR4PH+6dtu77j5nrKE+FVHfPB/KTI8
u7KodXymcllQ3MQ5ww3jrV9IUrsK2M9E5xK2gzGxtkp0/nMx2Fin5mBAOmGjusRBQkQTGpoi
1Xhv4xqNhzUibOqteHbd9KMk7cqynkSgpeTT59BaPyD3xgfLJU9gsiDcYTnXaQlacYGY00lQ
mmx5ovCBLbyvAtsn3DmbSp4/n5bfgd7izGwp8hkoeT4O2S0ymoSA1/G/VAy3nZpsOcn9XdSV
Fi6M0FP/pDU7RUbGKp6tj+edltcgh4DM0SmYV85zs9/hQpcVUOlToVA9qZX1RtwBd9ozHLEu
ZYu+GmfZ4OQG1lbXYkJGDLssQ9gj57cTY2z7cmKDmEQ3qF6743XJd2o2RGVgGLTCQNTF7Xis
wUuYSoN/Doe2XYJsMV9jG+m27otyhl3sR7V5Oq+/3Ffm+CswyfDZYtyEp1GSa//g1EZcb6a/
yrBIsu4QRfuTpg5r2aq6rzquHYETDlnKg92l7tHecN9kzUqS6uFw/Bkk6/36W/WAOmJIPHMn
JdWA0qRVAIbI2T7eyWJwf1luOGhyxg9WxUyn/FTLIyLI2exWgaCHssy7hKMvoSgs72u5pgNx
nXKZ5tcfLj53WVzKQAYhRjcOfZ44hciYgU7p1A9V2kiKNNdHV3jtzy3gdvC7TAjcNN9NCtxg
3RkvJPBkWJ/I1PUJncjPfdZslsA2cCl91QsmTV7oPeiYgg2bgP2aJUTOUX31i4lV6m21own/
IPwYCxMIwJw5e1tDypATrFhdpNwqFeovUARnIw1s2Lr3ZzG+5FUEKUnhs/s6sp2zW2Q+PHVn
z7O6wqrDZ3wLs858l+Ascs+IQJaluLDpyfCMP4ecakPCkmKFF7puIZUSYs4Zzou6j0XOvdhI
FPisNZLg5yUGxxQ+bV6PqS2Ch8lmS20LrbMlmrVgt6cizPwiYCgkWf6CQmOBiRCMCtyP69Hh
n9Pn3HFHQ4sJt6pHralq8dcvNk9fdpsXbu9J+NEXu8H+XPm2R98g0InPWHsHNGBjTWoCliDJ
fMYEiOvkCQ9msmeQIMQhpZ4d1wdnOY6TnvOyHCQEP6/P8ZJufOkZYSJ5OMXyX5P8mO1XxBar
BoR2tohJWn66uHx3g6JDRqE1Pr+Y4qVNkpMY37vV5Ue8K5LhkXQ2E77hOWNMz/vjB6+m+w83
Q+qJ3GEziIlRUbTIWLpQS55T3EwslL7z4HFMMCNd6PNrbpJ57Ht98ogPOVN+q1/PFDIIL0X8
HkIeBSpQPkeV0uHlgTZ0qFMGU1qREAb/gobGRCmOmRpj1VblpFC3pXsmNrmJB644OFenc1s1
sNpn83zKUncOjccftRwgbO9usZYkkoS+ZZEUlyBcWkkE65M+CxCVc4oFhUsuGWTx7qFzNNVi
/26UfXWIfVVtT8H5EHypYJ06Vt7qODlICDUEVkrUQHQ4pUtKM4Cs6uPci37EJQcobuuiOfek
73pHPnsCTsIjHMGyWelLqtMIZ16mwP7HeOBrHHOE4+JlXqQpw2cfER6LhesZDJPrKmAQHnd/
1cllXw7cbRpwILpAsQ/s6qPDGYvxKjuoX55kdlm/hZSJrqk5R2FpSGKn2JfJuvuIy2RJIH4y
t9tavYl2x4e/18cquD+st9XRSoaWpg5klxbZCoLzrh99Na7nSUtdX58YLwWhxMszjfIN59WV
GCGFWJrCh5MBdnyZFPBfyRee0RsCtpCeELEm0DcJm24g0U5gt3G3rckIRJ20Jc6kmGDe1zq5
a+63OBfLPDJidmjydAq2XQW+a2KD7cwTxNZbIZ+mnmJYkuOuUETIWprKE1YXM0cpkxg7sGpJ
ikmItQSwDt+xO3stCYWN7+77DXCxEFlfHLChJl82pefrT+NhqbzNcqHpni2yhXKCeaZu2ZPQ
HKsMwJLgwRvEQKU2IPq45NlhB6PWjm6RsEA9PT4ejmdbHhx4XfHYnTaO5LQiXiTJra76oGND
dhwLVYCdAEU2goqb48vhaV1dL2KgAUlwsubX9msw5ef3dHWFavygaX0ptPqxPgV8fzofnx7M
7YvTdzAK2+B8XO9Pmi643+2rYAtL3T3qf9os+X+0Ns3J/bk6roMom5Lga2uHtoe/99oWBQ8H
XcwLXh6r/33aHSsY4JK+ao0935+r+yDhNPiv4Fjdm3vjPTMGJFqFa41vcYqC9xuDFyCeDrQP
KkHAITAa7UM/iDkNd7vrkXR93GJT8NIf+nN1dYbV2YWSl1So5NXQ/em5W/Nuy6LP8MmSGToT
qKw4ot1MG8LQGmIxvHWLgNSHAs6BFOGhvjstcflWo7C2vcuJDGQZUtyO5kROdYw7uAXYRyK9
T7Cik6aI2psFkYaDZNZWadsEsZvCXMH3x/8581gniPt03udLzn2oxcqH0b7P40CnniwW5gBp
vm/utD7Ox6oSRWpzAT7LheGkuTDvCQQXPjOcxolbwa01T0eovQXZuuIe7sDa7L48aYFWf+/O
m+8BsU7vLPJOov5pky4M04fszvF7fTCehkJCfESoLu6bFwEIOiF3tv+0USAyac4JjpQUhxdS
SLwJJQteJDgKXAdP8Wbsjs7sKwEWairE1Lm436NmBVkyjqL4p8uPqxWOci8mWZiEyAWLPTgO
4uSdpMEqluCTSUnux7FcilQk+ApTvNGn958vUIQ2ADpacmxeMiiYjJtJUFZFFNql1AUMiaIg
z1KFfZnUxomYyCgmEl+YEpRDwrLC5RliQpGpW3xCC+6UshLIx5vo2lMwuh0kkC0iy2yzAZ/6
YcWwZuvgQ6YPhzzjZO21DC86yTJ/W1NnH977simEvy0ZBtEO1qQqeY7V+81FnP4aUTyjNks0
tkvYPHUzQ6NAc/Aqh0En+jBN/+tqZFd1oPL6tNtWQaEmrWs1VFW1baoUGtPWa8h2/aivLY28
/TK271/pr85ahUnO5h5c7ryhgk/vuwK3WWKbEBs1kZDnAs9wLOWKChw1MEtDlFQ8tqdqrnZh
pwt2w5FBc5As5MTLGUncp4MOjpHY31BxHKFyHJ576O9uQ9sk2SjjtFhqnEmdgZiiVrDc6brU
y3EN75Uufp2qKjh/b6lsn9wO4YllzBkRUv9p0QvH3sJnmQ3S4XqU7tLddni3DrTTPQb8/Enf
PbSWH7MpobdeYJPsvrcucKblVOHBXnNt2mdrTD6P24s4BAE2D1ea60BdAWVRn6FbJZXFHEC4
UWCSk7i+M1Pgkfhsidxtb/mTxA3SDe2XaA2ofdU2Yn6d5VxSLG/VYKwXm9yifo8bX5UleJV8
5qmeZ9k4qcsgWt7cHzZ/YvMEZPnu46dP9dvKcWJeq0XjAvV1aO9ZmaUf6+3W3KBZ39cDn97Y
get4PtZ0eEpziRdQpxkXvkpuJpYMrOrC8/7KYMEHec59ary+Shx7jjYhdE4IPq0l0QciAj9/
kWxaxMNnE3V997h+/L7bnJxNaet6Q1znX51rurpGS2PCLVcBnq4UM8rLmOd5zEqwdpy4N2KX
OAdB1ZR+T+qxX0swFZ5TSEL1O1I+gdjDVfk6s0nIpIisiw69cOuoAgIehirKoJ01XLECG5L5
XqYVnsMVc2+1Vm/szp5GQxiYsLRoXUKy2xwPp8PXczD7+VgdXy+Cb0/V6Yxt2K9IrUXnZOq9
prLUN7tQPaRGX9Th6bhBk0EUbyfGPJ6IFbJuDrF+YT2Acc4eDDLI1t+q+noUUj/8FWn90Ld6
OJwrXQPC5o5g61aPD6dvaAMHYfFWa4c+3xqxD5KF4KUyj38DsQdTvnt8FXRPAwalJ/Jwf/gG
YHWg2OgYum4HHepc3NNsjK3r9MfDers5PPjaofi6pLvK3kbHqjpt1sDwm8OR3/g6+RWpod29
SVa+Dka42vetsg8/fozatKIF2NWqvEmmntsQNT4dpjStpxx3bnq/eVrfAz+8DEPxtpBAKsNH
ErLS18HHS2n6xLBdZe8fyZblbBIdt0SSeQrpK12o8ploIXGrxz1WL1smo6XqEv4GZokZshHO
dmXKFBf1vfU4Rs4xISJwnvM7lTx9iqUJsJ12Gw7cMvVcMZRkHOmQ/fZ42G3tsSHKk4KH6Lgt
uRVzeg6l9SnJmJGzpS7obXSWgERWangHp31nNm7VNzKHB2gkyIXn8lrME18MbNI+Wp/t4ccx
9bNT3AG7x9LNsS+Yj3qfHFVfQK4X6meSkUKui7drU9rbEOfkFaT9EhA+TXg/wPWYD6V9sG0A
+sGJfjqu+xyM8cFMzDzXJhQP41oqxWjhvV9viHz5/R+T0BlXf3uJ9SH8xFyv7VchGdcvlVW9
NEvxGrD5bQBPmNmQ6J+tgG2PcGtgDVCu9CEGSvWHIUBRKz9qGinvTk5y6W+Y8viZptGlv6X+
DQOCBTVspaMZl4strH6dUYoMEywdjZoXw84L90Tfjsj1j+YM8PZMWGoOhfHL25FKRc4jK0UP
hwBeA8rmpwj6rkmNQHq9KUTuVDINoLsUZrQ/IujPLZgfKWjo9c8wDdZTI0ay2+P1zfrFu2dw
l775Or/joOsAkTK6/ODCalDPBaPcuBjoogpkAwN0bZ7Wm+/uKXakkDvtbRBdU9fk4Wspkrfh
IjRGr7d57XYp8fnq6sKZ+R+Qnrq3n++AzDPrIoxGC2rngY9dp1NCvY1I/jbNB/PqowTz4sUz
6gLaehUxR1StdQb4sLXfP1VP24N5OzFik7FHkfPrGACYu+88DGz0+1YaaK72JyLloH3OnXiN
pDMeh5Jh+qYfJtujml/06D/ba1F9fm9uRT3vIGqakdnsY7MoLKlk4AWdq3Xmj5+xCPO6LnWl
TFscmH3O3N/MEJKkU+Y3jSR8Bhf5cbNnUVlceNGTZ2Yz8aOeaUUlSTwodVMQNfPJ+DNeSv/w
wMprSJJnVp/5cTfp6sOz2Cs/Vj43aPbMDwDdqoWv2f9Vdm29beNK+P38CqNPZ4G2iJM0l4c+
UDJtq5Elh5LiJC+G6+gkQhs7sB1ss7/+cIakrhzKC+wiu5rPFDm8j2a+yTollmYcZbsjBlXk
2KTHCcHyA/6VVAcGlCAeMXp0UpWvc8vI/ym5TT4V++3V1bfrL8OaZyEA5Gs4riDnZ5f2VtVB
l0eBLu3e5g3Q1beTY0B2T/cW6KjXHVHxq4tj6nRh39JboGMqfmEnlGuBCD/7JugYFVwQwR9N
0HU/6PrsiJKuj+ng67Mj9HR9fkSdri5pPckDBoz9pZ1FplHM8PSYaksUPQhY4gdEFFStLvTv
DYLWjEHQw8cg+nVCDxyDoPvaIOipZRB0B5b66G/MsL81Q7o5N3FwtSR8tozYHqAG4hnzYRui
Pl1qhM8hiq8HIm8cmbDfPUuQiFka9L3sQQRh2PO6CeO9EME58UVDIwLZLnm9c2OiLLDbTxrq
62tUmombgAi5AUyWju2zOIsCmJ7W82PDIqNs3fn6fVccPmyfXG74A3Gg0laP5WjGE7T1pSIg
jEZOC4kRWrdwDCabMjHiER/hTdeP5w8Vt1jDPaENs79OsR0BBnxEHLEQKr6waiereaaFyez7
p4/V6+ozuOq+FZvP+9X/cvnz4ulzsTnkz6DPTw1OuJfV7infNEN46wHjxaY4FKvfxT+Gx7m8
5gepJkzS5CqVBaVi/VCMHyFnN3QMrh3uPQhuj4Rx4EnCDKytItSQFy6jRMI8bcDABUBim/HS
bS21aPQsSi6t7u1RbhSsXPPNlyx/9/F22A7W210+2O4GL/nvt3q0igLL5k1YnV+x8fi08xyi
mqwPG+Y//VwuDHJbtXehhpBdrOVRRnSPluMf4niuW5KlU044eGlImwVbXe3ff/4u1l9+5R+D
NWryGb5Mf9SXFP1zQcSCavHIvuxpKff75KIVa6rM/e+Hl3wDjOvgA8s3WEUg7vi7OLwM2H6/
XRcoGq0OK0udfd/uXaLFE7fYnzL5z+nJPA4fhmcn9t3Z6J9PgmR4al/eWxhnVyPo9Jv93GJG
XCyy5OLcftarY+TLnKCE3wb2CM6yX6ZMzvq7Ts94+Dn6dfvUNL4ZzXnOkeiP7R4KRkyYrUsx
ZU3QVXYWHoqFSxy7qzbvadm9u25yd14IilFD9z+4c6SZ5VvUav9CK1weP1ylTnvk9z3tumv9
Xru0P+f7Q2et9YV/dupbFkoUOGtxD2useyH00+HJiAoF1dO6r5RjJvRsZD+wl2L3rwM5cXgI
f10wMRv1rBmAIC72FaJnuZCIs1P3OjBl9itdJe95h0R8Gzo7VyLstyQjn7nFqTx0eIQTltnh
JmJ47azEYt6qpZpLxdtLy7WhXI2d85lhNoA+hKILdaKizAvcbxK+swQvjBdj6u5hJg+bcXnn
cm7jwOLiHNkAcI6EkVtlY/zrXCSn7JEgijNjgYUJc49os3e7dz+Kxd7IxVxeeN2D1tkrKXcq
O13EfX2mIZYxpEbr9vVtl+/36gbS7Qo6FsFsh48EU4ESX507p1P46Gy+FE+d699jknYDWcVq
87R9HUTvrz/znaY6PNgbyKIkWPpzQbjbGTUIb4J+fy7QjyBNuXBxNtbO8kt5a1j27TIlMLnx
g/m0/4aA4J62lDjGrVyMZr9flPejfHcAPyV5TN5jqMS+eN4g3/Fg/ZKvf7WYNI+BIz4sfu5W
8oK3274fik2bt6/D1KUlXpAC64BIah8HjfMQ0hilQWhhQR4H0Qj4BZJ02eJF82PRSuhS05gv
LwCyW61q8jFFQAPsPFn4yyDNlkRZZ617oXwgV49wTCQe0oAw8Ln3cGX5qZJQcwshTCzoqQ0I
j7BoSSm5GZF7jG+3koaBp0571M/sZxvlmU/oqETdPwKRkEV9im57xkiyPJTJOUK55oxu6wF8
IXzwbRBqiVvkk7H9MpjJNtc+O8s3txyewK4WTYim6VnWmTxNw5OZlfj0bVdsDr/QM//pNd8/
26x+Og8NeOtbVanlkD/BajzzVeAs5LBRhOTmy9slibjNwBPivPo6niTwcaFTwnlVCy+OU1OV
UTfxiNYN2d5ywyt+518w8RCuSHuErnX+NJt2FHVH22dKC3mExOSzLEmV+1XVuWMhD0zoPPN9
eHJ63uziOaZIa/PDVkNcLs9YMCMCbDTDrCzAiwkGJ1Vv6lO2yaWCzJ2Uw7kqIuHIOQn+BjPW
oqEyTWpBVOq2OAof2vrA1DVNDyZdUaT5XYDNURNOWvv36B6snLNKYvqKJhR77fvJn6ENpYKH
6qFHUD/FZd9+iuyhHw3L7ij/+f783CKLwk9n/D7lURIQ5lFVIABpPkssJl5EVAgoiKWGk7in
S2PvB6cMIbrTQ2YLaUULvVbIjM/ARNztSiNxFY8W7gwmvQN1Z2ctRcWrLHVgU66ZWhVJ+Q1L
WGR2/0qqHuObvw//0zY1V93W2CiwPL+en8IwobNIPtaRbvOGwQLwrrZPWyQpyhwC7x+E2/Wv
9zc1pKerzXMzICYeIzEs5qZKaT4eJVxOs0hlaLOCFrdEZFLp3muvT320RXLOyFkf250lG3Jw
Ac54RRauhLDlxFlaPTZcySopUtVyeEzzr6pfqTHF5VmPdoTVPEzytTectykc1ckULJPlYBj8
d/9WbDBG7fPg9f2Q/8nlf+SH9devX/+qbFfoMoplT3D3LsNlantofFe6htpPQ1AGtNFR8YqK
3TW+LEFCLUh/IYuFAsmFIF7MGUFloWu1SDixkSkANo1e1SoQKA/vPPr4Yy8Ui5ODPwU6IfIA
WLXAeZb6F91dDtIyM1C9h3HLk42UezOYBoCuls6dpBdKtQ6711n5r7zyeHH90mORtLUZEGrR
20yPnCCiV0J0OA44QXGjML6QKgDej+bpRF3R/cy+S0IWR0gDR3cqIHp7HkGCEXQNmCryNrF5
L9eSQda2g/bMuNVnFWE5pTT7Bweq3PWRWM8KNKpccmCfltvZD94h+C7B6vDixmgi/TS2Re6D
Uprrkym5M5p1rg24zKiEqta3SbHclMZK2/bNSK3NDsB0AXToDoA+Y5cUwIiksi+AbJlEbA5p
XW0mBDkp5bauEpLxzjd285xFsmcw9aH6AbFWlnDgp3MBy/QMsWNkokTldiTYxLudgzchKkWx
gPwrMzVToN919Gr1QiAaxDRvSSdHUh1CSr0qRRpQ79Mz0gP7u0MOPPPyhhjP5HGBROHNQZ4j
lu7CNF07KYcsaIF/ce62H2DDp/weuCAdmlHXdeVXQoxJjUt8wjKIgBuJSIkQLgTgzdduXkK5
MiU45XKhCQkiMUBkWTsOri69Z0IQIdUohyiLsTwr0AgBJk9M5OVQOGUVRWkwshvE1Ti+Ibgo
QHjnSBKgGp8gdairi7y5S/2hnArTGNcp++EfrZCQ3Mg9t7E0Q4bqGFAYDuFoj8VE0hyQ6BhF
OnypQTmLHSMCEgrLlds5O9CUS5gSTSEkQMrI6Ym32Gg5AtJLPxYi64RWVTsQkvUSrvBewmwB
IvhcLuvBJJKLZm2n5EyED1UO165HkrK+/R8HmUNi8X8AAA==

--q3pyezv7obcxgzvx--
