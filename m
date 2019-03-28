Return-Path: <SRS0=SA5R=SA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.4 required=3.0 tests=DATE_IN_PAST_06_12,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD681C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 02:24:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F6132173C
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 02:24:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728637AbfC2CYL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Mar 2019 22:24:11 -0400
Received: from mga09.intel.com ([134.134.136.24]:62117 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727434AbfC2CYK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Mar 2019 22:24:10 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 28 Mar 2019 19:22:07 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,282,1549958400"; 
   d="scan'208";a="138336516"
Received: from iweiny-desk2.sc.intel.com ([10.3.52.157])
  by fmsmga007.fm.intel.com with ESMTP; 28 Mar 2019 19:22:07 -0700
Date:   Thu, 28 Mar 2019 11:21:00 -0700
From:   Ira Weiny <ira.weiny@intel.com>
To:     Jerome Glisse <jglisse@redhat.com>
Cc:     John Hubbard <jhubbard@nvidia.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Dan Williams <dan.j.williams@intel.com>
Subject: Re: [PATCH v2 02/11] mm/hmm: use reference counting for HMM struct v2
Message-ID: <20190328182100.GJ31324@iweiny-DESK2.sc.intel.com>
References: <20190325144011.10560-3-jglisse@redhat.com>
 <20190328110719.GA31324@iweiny-DESK2.sc.intel.com>
 <20190328191122.GA5740@redhat.com>
 <c8fd897f-b9d3-a77b-9898-78e20221ba44@nvidia.com>
 <20190328212145.GA13560@redhat.com>
 <fcb7be01-38c1-ed1f-70a0-d03dc9260473@nvidia.com>
 <20190328165708.GH31324@iweiny-DESK2.sc.intel.com>
 <20190329010059.GB16680@redhat.com>
 <55dd8607-c91b-12ab-e6d7-adfe6d9cb5e2@nvidia.com>
 <20190329015003.GE16680@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190329015003.GE16680@redhat.com>
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 28, 2019 at 09:50:03PM -0400, Jerome Glisse wrote:
> On Thu, Mar 28, 2019 at 06:18:35PM -0700, John Hubbard wrote:
> > On 3/28/19 6:00 PM, Jerome Glisse wrote:
> > > On Thu, Mar 28, 2019 at 09:57:09AM -0700, Ira Weiny wrote:
> > >> On Thu, Mar 28, 2019 at 05:39:26PM -0700, John Hubbard wrote:
> > >>> On 3/28/19 2:21 PM, Jerome Glisse wrote:
> > >>>> On Thu, Mar 28, 2019 at 01:43:13PM -0700, John Hubbard wrote:
> > >>>>> On 3/28/19 12:11 PM, Jerome Glisse wrote:
> > >>>>>> On Thu, Mar 28, 2019 at 04:07:20AM -0700, Ira Weiny wrote:
> > >>>>>>> On Mon, Mar 25, 2019 at 10:40:02AM -0400, Jerome Glisse wrote:
> > >>>>>>>> From: Jérôme Glisse <jglisse@redhat.com>
> > >>> [...]
> > >>>>>>>> @@ -67,14 +78,9 @@ struct hmm {
> > >>>>>>>>   */
> > >>>>>>>>  static struct hmm *hmm_register(struct mm_struct *mm)
> > >>>>>>>>  {
> > >>>>>>>> -	struct hmm *hmm = READ_ONCE(mm->hmm);
> > >>>>>>>> +	struct hmm *hmm = mm_get_hmm(mm);
> > >>>>>>>
> > >>>>>>> FWIW: having hmm_register == "hmm get" is a bit confusing...
> > >>>>>>
> > >>>>>> The thing is that you want only one hmm struct per process and thus
> > >>>>>> if there is already one and it is not being destroy then you want to
> > >>>>>> reuse it.
> > >>>>>>
> > >>>>>> Also this is all internal to HMM code and so it should not confuse
> > >>>>>> anyone.
> > >>>>>>
> > >>>>>
> > >>>>> Well, it has repeatedly come up, and I'd claim that it is quite 
> > >>>>> counter-intuitive. So if there is an easy way to make this internal 
> > >>>>> HMM code clearer or better named, I would really love that to happen.
> > >>>>>
> > >>>>> And we shouldn't ever dismiss feedback based on "this is just internal
> > >>>>> xxx subsystem code, no need for it to be as clear as other parts of the
> > >>>>> kernel", right?
> > >>>>
> > >>>> Yes but i have not seen any better alternative that present code. If
> > >>>> there is please submit patch.
> > >>>>
> > >>>
> > >>> Ira, do you have any patch you're working on, or a more detailed suggestion there?
> > >>> If not, then I might (later, as it's not urgent) propose a small cleanup patch 
> > >>> I had in mind for the hmm_register code. But I don't want to duplicate effort 
> > >>> if you're already thinking about it.
> > >>
> > >> No I don't have anything.
> > >>
> > >> I was just really digging into these this time around and I was about to
> > >> comment on the lack of "get's" for some "puts" when I realized that
> > >> "hmm_register" _was_ the get...
> > >>
> > >> :-(
> > >>
> > > 
> > > The get is mm_get_hmm() were you get a reference on HMM from a mm struct.
> > > John in previous posting complained about me naming that function hmm_get()
> > > and thus in this version i renamed it to mm_get_hmm() as we are getting
> > > a reference on hmm from a mm struct.
> > 
> > Well, that's not what I recommended, though. The actual conversation went like
> > this [1]:
> > 
> > ---------------------------------------------------------------
> > >> So for this, hmm_get() really ought to be symmetric with
> > >> hmm_put(), by taking a struct hmm*. And the null check is
> > >> not helping here, so let's just go with this smaller version:
> > >>
> > >> static inline struct hmm *hmm_get(struct hmm *hmm)
> > >> {
> > >>     if (kref_get_unless_zero(&hmm->kref))
> > >>         return hmm;
> > >>
> > >>     return NULL;
> > >> }
> > >>
> > >> ...and change the few callers accordingly.
> > >>
> > >
> > > What about renaning hmm_get() to mm_get_hmm() instead ?
> > >
> > 
> > For a get/put pair of functions, it would be ideal to pass
> > the same argument type to each. It looks like we are passing
> > around hmm*, and hmm retains a reference count on hmm->mm,
> > so I think you have a choice of using either mm* or hmm* as
> > the argument. I'm not sure that one is better than the other
> > here, as the lifetimes appear to be linked pretty tightly.
> > 
> > Whichever one is used, I think it would be best to use it
> > in both the _get() and _put() calls. 
> > ---------------------------------------------------------------
> > 
> > Your response was to change the name to mm_get_hmm(), but that's not
> > what I recommended.
> 
> Because i can not do that, hmm_put() can _only_ take hmm struct as
> input while hmm_get() can _only_ get mm struct as input.
> 
> hmm_put() can only take hmm because the hmm we are un-referencing
> might no longer be associated with any mm struct and thus i do not
> have a mm struct to use.
> 
> hmm_get() can only get mm as input as we need to be careful when
> accessing the hmm field within the mm struct and thus it is better
> to have that code within a function than open coded and duplicated
> all over the place.

The input value is not the problem.  The problem is in the naming.

obj = get_obj( various parameters );
put_obj(obj);


The problem is that the function is named hmm_register() either "gets" a
reference to _or_ creates and gets a reference to the hmm object.

What John is probably ready to submit is something like.

struct hmm *get_create_hmm(struct mm *mm);
void put_hmm(struct hmm *hmm);


So when you are reading the code you see...

foo(...) {
	struct hmm *hmm = get_create_hmm(mm);

	if (!hmm)
		error...

	do stuff...

	put_hmm(hmm);
}

Here I can see a very clear get/put pair.  The name also shows that the hmm is
created if need be as well as getting a reference.

Ira

> 
> > 
> > > 
> > > The hmm_put() is just releasing the reference on the hmm struct.
> > > 
> > > Here i feel i am getting contradicting requirement from different people.
> > > I don't think there is a way to please everyone here.
> > > 
> > 
> > That's not a true conflict: you're comparing your actual implementation
> > to Ira's request, rather than comparing my request to Ira's request.
> > 
> > I think there's a way forward. Ira and I are actually both asking for the
> > same thing:
> > 
> > a) clear, concise get/put routines
> > 
> > b) avoiding odd side effects in functions that have one name, but do
> > additional surprising things.
> 
> Please show me code because i do not see any other way to do it then
> how i did.
> 
> Cheers,
> Jérôme
